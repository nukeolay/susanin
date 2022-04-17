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
  late final MainPointerState _currentState;
  MainPointerLoaded _state = const MainPointerLoaded(
    position: PositionEntity(
      longitude: 0,
      latitude: 0,
      accuracy: 0,
    ),
    compass: CompassEntity(0),
  );

  MainPointerCubit({
    required this.getPositionStream,
    required this.getDistanceBetween,
    required this.getCompassStream,
  }) : super(MainPointerLoading()) {
    _currentState = state;
  }

  void loadMainPointer() {
    loadPosition();
    loadCompass();
  }

  void doThings() {
    final _stream =
        StreamGroup.merge([getPositionStream(), getCompassStream()]);
    _stream.listen((event) {
      event.fold((error) {

        emit(MainPointerError(
          isServiceEnabled: error is! LocationServiceDisabledFailure,
          isPermissionGranted: error is! LocationServiceDeniedFailure,
          isCompassError: error is CompassFailure, // ! TODO

        ));
      }, (event) {
        if (event is PositionEntity) {
          
        } else if (event is CompassEntity) {
          
        }




      });
    });
  }

  void loadPosition() {
    final failureOrPointerStream = getPositionStream();
    failureOrPointerStream.listen((event) {
      event.fold((error) {
        emit(MainPointerError(
          isServiceEnabled: error is! LocationServiceDisabledFailure,
          isPermissionGranted: error is! LocationServiceDeniedFailure,
          isCompassError: error is CompassFailure, // ! TODO
        ));
      }, (position) {
        _state = MainPointerLoaded(
          position: position,
          compass: _state.compass,
        );
        emit(_state);
      });
    });
  }

  void loadCompass() {
    final failureOrCompassStream = getCompassStream();
    failureOrCompassStream.listen((event) {
      if (_state.position != null) {
        event.fold((error) {
          emit(MainPointerError(
            isServiceEnabled:
                error is! LocationServiceDisabledFailure, // ! TODO
            isPermissionGranted:
                error is! LocationServiceDeniedFailure, // ! TODO
            isCompassError: error is CompassFailure,
          ));
        }, (compass) {
          _state = MainPointerLoaded(
            position: _state.position,
            compass: compass,
          );
          emit(_state);
        });
      }
    });
  }
}
