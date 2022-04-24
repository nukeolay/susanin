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
          isLoading: true,
          position: PositionEntity(longitude: 0, latitude: 0, accuracy: 0),
          compass: CompassEntity(0),
          isCompassError: false,
          isPermissionGranted: true,
          isServiceEnabled: true,
          isUnknownError: false,
        )) {
    _init();
  }

  void _init() {
    final _stream =
        StreamGroup.merge([_getPositionStream(), _getCompassStream()]);
    _stream.listen((event) {
      event.fold(
        (error) {
          final _state = state.copyWith(
            isLoading: false,
            isServiceEnabled: error is! LocationServiceDisabledFailure,
            isPermissionGranted: error is! LocationServiceDeniedFailure,
            isCompassError: error is CompassFailure,
            isUnknownError: error is LocationServiceUnknownFailure,
          );
          emit(_state);
        },
        (event) {
          if (event is PositionEntity) {
            final _state = state.copyWith(
              isLoading: false,
              position: event,
              isPermissionGranted: true,
              isServiceEnabled: true,
              isUnknownError: false,
            );
            emit(_state);
          } else if (event is CompassEntity &&
              !state.isLoading &&
              state.isPermissionGranted &&
              state.isServiceEnabled &&
              !state.isUnknownError) {
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
