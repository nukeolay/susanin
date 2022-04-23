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
  final GetPositionStream getPositionStream;
  final GetDistanceBetween getDistanceBetween;
  final GetCompassStream getCompassStream;

  MainPointerCubit({
    required this.getPositionStream,
    required this.getDistanceBetween,
    required this.getCompassStream,
  }) : super(const MainPointerState(
          isLoading: true,
          position: PositionEntity(longitude: 0, latitude: 0, accuracy: 0),
          compass: CompassEntity(0),
          isCompassError: false,
          isPermissionGranted: true,
          isServiceEnabled: true,
          isUnknownError: false,
        )) {
    _initialize();
  }

  void _initialize() {
    final _stream =
        StreamGroup.merge([getPositionStream(), getCompassStream()]);
    _stream.listen((event) {
      event.fold((error) {
        final _state = state.copyWith(
          isLoading: false,
          isServiceEnabled: error is! LocationServiceDisabledFailure,
          isPermissionGranted: error is! LocationServiceDeniedFailure,
          isCompassError: error is CompassFailure,
          isUnknownError: error is LocationServiceUnknownFailure,
        );
        emit(_state);
      }, (event) {
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
      });
    });
  }
}
