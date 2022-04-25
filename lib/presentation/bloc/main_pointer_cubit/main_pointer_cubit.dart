import 'package:async/async.dart' show StreamGroup;
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

  MainPointerCubit({
    required GetPositionStream getPositionStream,
    required GetDistanceBetween getDistanceBetween,
    required GetCompassStream getCompassStream,
  })  : _getCompassStream = getCompassStream,
        _getDistanceBetween = getDistanceBetween,
        _getPositionStream = getPositionStream,
        super(const MainPointerState(
          position: PositionEntity(longitude: 0, latitude: 0, accuracy: 0),
          compass: CompassEntity(0),
          isCompassError: false,
          status: MainPointerStatus.loading,
        )) {
    _init();
  }

  void _init() {
    final _stream =
        StreamGroup.merge([_getPositionStream(), _getCompassStream()]);
    _stream.listen((event) {
      event.fold(
        (error) {
          final MainPointerState _state;
          if (error is LocationServiceDeniedFailure) {
            _state = state.copyWith(
              status: MainPointerStatus.permissionFailure,
            );
          } else if (error is LocationServiceDisabledFailure ||
              error is LocationServiceDeniedForeverFailure) {
            _state = state.copyWith(
              status: MainPointerStatus.serviceFailure,
            );
          } else if (error is CompassFailure) {
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
              position: event,
            );
            emit(_state);
          } else if (event is CompassEntity &&
              state.status == MainPointerStatus.loaded) {
            final _state = state.copyWith(
              compass: event,
              isCompassError: false,
            );
            emit(_state);
          }
        },
      );
    });
  }
}
