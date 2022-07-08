import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_state.dart';
import 'package:susanin/presentation/bloc/mixins/pointer_calculations.dart';

class DetailedInfoCubit extends Cubit<DetailedInfoState>
    with PointerCalculations {
  final GetPositionStream _getPositionStream;
  final GetCompassStream _getCompassStream;

  late final StreamSubscription<Either<Failure, PositionEntity>>
      _positionSubscription;
  late final StreamSubscription<Either<Failure, CompassEntity>>
      _compassSubscription;

  DetailedInfoCubit({
    required GetPositionStream getPositionStream,
    required GetCompassStream getCompassStream,
  })  : _getPositionStream = getPositionStream,
        _getCompassStream = getCompassStream,
        super(const DetailedInfoState(
          locationServiceStatus: LocationServiceStatus.loading,
          errorMessage: '',
          hasCompass: true,
          distance: '',
          positionAccuracy: 0,
          angle: 0,
          pointerArc: 0,
          locationName: '',
          locationLatitude: 0,
          locationLongitude: 0,
          userLatitude: 0,
          userLongitude: 0,
        )) {
    _init();
  }

  void setActiveLocation(LocationPointEntity activeLocation) {
    emit(state.copyWith(
        locationServiceStatus: LocationServiceStatus.loading,
        locationName: activeLocation.name,
        locationLatitude: activeLocation.latitude,
        locationLongitude: activeLocation.longitude));
  }

  void setCurrentPosition(PositionEntity currentPosition) {
    _positionValueHandler(currentPosition);
  }

  void _init() async {
    _compassSubscription = _getCompassStream().listen(_compassHandler);
    _positionSubscription = _getPositionStream().listen(_positionHandler);
  }

  void _positionHandler(Either<Failure, PositionEntity> event) {
    event.fold(_positionFailureHandler, _positionValueHandler);
  }

  void _positionFailureHandler(Failure failure) {
    if (failure is LocationServiceDeniedFailure ||
        failure is LocationServiceDeniedForeverFailure) {
      emit(state.copyWith(
          locationServiceStatus: LocationServiceStatus.noPermission,
          errorMessage: 'error_geolocation_permission'));
    } else if (failure is LocationServiceDisabledFailure) {
      emit(state.copyWith(
          locationServiceStatus: LocationServiceStatus.disabled,
          errorMessage: 'error_geolocation_disabled'));
    } else {
      emit(state.copyWith(
          locationServiceStatus: LocationServiceStatus.unknownFailure,
          errorMessage: 'error_unknown'));
    }
  }

  void _positionValueHandler(PositionEntity position) {
    final distance = getDistance(
      startLatitude: position.latitude,
      startLongitude: position.longitude,
      endLatitude: state.locationLatitude,
      endLongitude: state.locationLongitude,
    );
    final accuracy = position.accuracy;
    emit(state.copyWith(
        locationServiceStatus: LocationServiceStatus.loaded,
        userLatitude: position.latitude,
        userLongitude: position.longitude,
        positionAccuracy: accuracy,
        distance: getDistanceString(distance),
        pointerArc: getLaxity(accuracy: accuracy, distance: distance)));
  }

  void _compassHandler(Either<Failure, CompassEntity> event) {
    event.fold((failure) {
      emit(state.copyWith(hasCompass: false));
    }, (compass) {
      emit(state.copyWith(
          hasCompass: true,
          angle: getBearing(
              compassNorth: compass.north,
              startLatitude: state.userLatitude,
              startLongitude: state.userLongitude,
              endLatitude: state.locationLatitude,
              endLongitude: state.locationLongitude)));
    });
  }

  @override
  Future<void> close() async {
    await _positionSubscription.cancel();
    await _compassSubscription.cancel();
    super.close();
  }
}
