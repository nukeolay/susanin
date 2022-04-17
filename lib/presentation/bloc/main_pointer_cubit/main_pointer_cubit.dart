import 'package:async/async.dart' show StreamGroup;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/data/compass/models/compass_model.dart';
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
  MainPointerLoaded _mainPointerData = const MainPointerLoaded(
    position: PositionEntity(longitude: 0, latitude: 0, accuracy: 0),
    compass: CompassEntity(0),
  );

  MainPointerCubit({
    required this.getPositionStream,
    required this.getDistanceBetween,
    required this.getCompassStream,
  }) : super(MainPointerLoading());

  void loadMainPointer() {
    getMainPointer();
  }

  void getMainPointer() {
    final _stream =
        StreamGroup.merge([getPositionStream(), getCompassStream()]);
    _stream.listen((event) {
      event.fold((error) {
        if (error is! CompassFailure) {
          emit(MainPointerError(
            isServiceEnabled: error is! LocationServiceDisabledFailure,
            isPermissionGranted: error is! LocationServiceDeniedFailure,
          ));
        }
      }, (event) {
        if (event is PositionEntity) {
          _mainPointerData = _mainPointerData.copyWith(position: event);
          emit(_mainPointerData);
        } else if (event is CompassEntity && state is MainPointerLoaded) {
          _mainPointerData = _mainPointerData.copyWith(compass: event);
          emit(_mainPointerData);
        }
      });
    });
  }

  void getCompass() {
    // ! TODO удалить, использую чтоюы проверять плавность компаса на разных версиях пакета flutter_compass
    Stream<CompassEvent> compassEvents = FlutterCompass.events!;
    compassEvents.map((event) => CompassModel(event.heading!)).listen((event) {
      emit(MainPointerLoaded(
          position:
              const PositionEntity(longitude: 0, latitude: 0, accuracy: 0),
          compass: event));
    });
  }
}
