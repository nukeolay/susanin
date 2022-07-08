import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/settings/usecases/get_active_location.dart';
import 'package:susanin/domain/settings/usecases/get_active_location_stream.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/bloc/mixins/pointer_calculations.dart';

class MainPointerCubit extends Cubit<MainPointerState>
    with PointerCalculations {
  final GetPositionStream _getPositionStream;
  final GetActiveLocationStream _getActiveLocationStream;
  final GetActiveLocation _getActiveLocation;
  final GetCompassStream _getCompassStream;
  late final StreamSubscription<Either<Failure, PositionEntity>>
      _positionSubscription;
  late final StreamSubscription<Either<Failure, LocationPointEntity>>
      _activeLocationStream;
  late final StreamSubscription<Either<Failure, CompassEntity>>
      _compassSubscription;

  MainPointerCubit({
    required GetPositionStream getPositionStream,
    required GetActiveLocationStream getActiveLocationStream,
    required GetActiveLocation getActiveLocation,
    required GetCompassStream getCompassStream,
  })  : _getPositionStream = getPositionStream,
        _getActiveLocationStream = getActiveLocationStream,
        _getActiveLocation = getActiveLocation,
        _getCompassStream = getCompassStream,
        super(MainPointerState(
          compassStatus: CompassStatus.loading,
          activeLocationStatus: ActiveLocationStatus.loading,
          locationServiceStatus: LocationServiceStatus.loading,
          mainText: '',
          subText: '',
          positionAccuracy: 0,
          activeLocationPoint: LocationPointEntity(
              id: '',
              latitude: 0,
              longitude: 0,
              name: '',
              creationTime: DateTime.now()),
          userLongitude: 0,
          userLatitude: 0,
          angle: 0,
          pointerArc: 0,
        )) {
    _init();
  }

  void _init() async {
    _activeLocationHandler(_getActiveLocation());
    _activeLocationStream =
        _getActiveLocationStream().listen(_activeLocationHandler);
    _compassSubscription = _getCompassStream().listen(_compassHandler);
    _positionSubscription = _getPositionStream().listen(_positionHandler);
  }

  void _activeLocationHandler(Either<Failure, LocationPointEntity> event) {
    event.fold(_activeLocationFailureHandler, _activeLocationValueHandler);
  }

  void _activeLocationFailureHandler(Failure failure) {
    if (failure is ActiveLocationEmptyFailure) {
      emit(state.copyWith(activeLocationStatus: ActiveLocationStatus.empty));
    } else {
      emit(state.copyWith(activeLocationStatus: ActiveLocationStatus.failure));
    }
  }

  void _activeLocationValueHandler(LocationPointEntity activeLocation) {
    if (state.isFailure) {
      emit(state.copyWith(
          activeLocationStatus: ActiveLocationStatus.loaded,
          activeLocationPoint: activeLocation));
    } else {
      if (activeLocation != state.activeLocationPoint) {
        final distance = getDistanceBetween(
                startLatitude: state.userLatitude,
                startLongitude: state.userLongitude,
                endLongitude: activeLocation.longitude,
                endLatitude: activeLocation.latitude)
            .toInt();
        emit(state.copyWith(
            activeLocationStatus: ActiveLocationStatus.loaded,
            subText: activeLocation.name,
            activeLocationPoint: activeLocation,
            locationServiceStatus: LocationServiceStatus.loaded,
            mainText: getDistanceString(distance),
            pointerArc: getLaxity(
              accuracy: state.positionAccuracy,
              distance: distance,
            )));
      }
    }
  }

  void _positionHandler(Either<Failure, PositionEntity> event) {
    event.fold(_positionFailureHandler, _positionValueHandler);
  }

  void _positionFailureHandler(Failure failure) {
    if (failure is LocationServiceDeniedFailure ||
        failure is LocationServiceDeniedForeverFailure) {
      emit(state.copyWith(
          locationServiceStatus: LocationServiceStatus.noPermission,
          mainText: 'error_title',
          subText: 'error_geolocation_permission_short'));
    } else if (failure is LocationServiceDisabledFailure) {
      emit(state.copyWith(
          locationServiceStatus: LocationServiceStatus.disabled,
          mainText: 'error_title',
          subText: 'error_geolocation_disabled'));
    } else {
      emit(state.copyWith(
          locationServiceStatus: LocationServiceStatus.unknownFailure,
          mainText: 'error_title',
          subText: 'error_unknown'));
    }
  }

  void _positionValueHandler(PositionEntity position) {
    final distance = getDistanceBetween(
            startLatitude: position.latitude,
            startLongitude: position.longitude,
            endLatitude: state.activeLocationPoint.latitude,
            endLongitude: state.activeLocationPoint.longitude)
        .toInt();
    final accuracy = position.accuracy;
    emit(state.copyWith(
        locationServiceStatus: LocationServiceStatus.loaded,
        userLatitude: position.latitude,
        userLongitude: position.longitude,
        positionAccuracy: accuracy,
        mainText: getDistanceString(distance),
        subText: state.activeLocationPoint.name,
        pointerArc: getLaxity(accuracy: accuracy, distance: distance)));
  }

  void _compassHandler(Either<Failure, CompassEntity> event) {
    event.fold((failure) {
      emit(state.copyWith(compassStatus: CompassStatus.failure));
    }, (compass) {
      emit(state.copyWith(
        compassStatus: CompassStatus.loaded,
        angle: getBearing(
          compassNorth: compass.north,
          startLatitude: state.userLatitude,
          startLongitude: state.userLongitude,
          endLatitude: state.activeLocationPoint.latitude,
          endLongitude: state.activeLocationPoint.longitude,
        ),
      ));
    });
  }

  @override
  Future<void> close() async {
    await _positionSubscription.cancel();
    await _compassSubscription.cancel();
    await _activeLocationStream.cancel();
    await _getPositionStream.close();
    super.close();
  }
}
