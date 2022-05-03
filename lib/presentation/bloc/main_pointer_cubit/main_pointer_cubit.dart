import 'dart:async';
import 'dart:math' as math;

import 'package:async/async.dart' show StreamGroup;
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  final GetPositionStream _getPositionStream;
  final GetDistanceBetween _getDistanceBetween;
  final GetCompassStream _getCompassStream;
  late final Stream<Either<Failure, Equatable>> _pointerStream;
  late final StreamSubscription<Either<Failure, Equatable>>
      _pointerSubscription;

  MainPointerCubit({
    required GetPositionStream getPositionStream,
    required GetDistanceBetween getDistanceBetween,
    required GetCompassStream getCompassStream,
  })  : _getCompassStream = getCompassStream,
        _getDistanceBetween = getDistanceBetween,
        _getPositionStream = getPositionStream,
        super(const MainPointerState(
          latitude: 0,
          longitude: 0,
          positionAccuracy: 0,
          angle: 0,
          compassAccuracy: 0,
          isCompassError: false,
          status: MainPointerStatus.loading,
        )) {
    _init();
  }

  void _init() {
    _pointerStream =
        StreamGroup.merge([_getPositionStream(), _getCompassStream()]);
    _pointerSubscription = _pointerStream.listen((event) {
      event.fold(
        (failure) {
          final MainPointerState _state;
          if (failure is LocationServiceDeniedFailure) {
            _state = state.copyWith(
              status: MainPointerStatus.permissionFailure,
            );
          } else if (failure is LocationServiceDisabledFailure ||
              failure is LocationServiceDeniedForeverFailure) {
            _state = state.copyWith(
              status: MainPointerStatus.serviceFailure,
            );
          } else if (failure is CompassFailure) {
            _state = state.copyWith(
              isCompassError: true,
            );
          } else {
            _state = state.copyWith(
              status: MainPointerStatus.unknownFailure,
            );
          }
          emit(_state);
        },
        (event) {
          if (event is PositionEntity) {
            final _state = state.copyWith(
              status: MainPointerStatus.loaded,
              latitude: event.latitude,
              longitude: event.longitude,
              positionAccuracy: event.accuracy,
            );
            emit(_state);
          } else if (event is CompassEntity &&
              state.status == MainPointerStatus.loaded) {
            final _state = state.copyWith(
              angle: (event.north * (math.pi / 180) * -1),
              compassAccuracy: (event.accuracy * (math.pi / 180) * -1),
              isCompassError: false,
            );
            emit(_state);
          }
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _pointerSubscription.cancel();
    super.close();
  }
}
