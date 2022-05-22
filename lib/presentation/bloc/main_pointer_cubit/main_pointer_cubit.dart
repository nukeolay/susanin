import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/constants/pointer_constants.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_bearing_between.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/settings/usecases/get_active_location.dart';
import 'package:susanin/domain/settings/usecases/get_active_location_stream.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  final GetPositionStream _getPositionStream;
  final GetActiveLocationStream _getActiveLocationStream;
  final GetActiveLocation _getActiveLocation;
  final GetCompassStream _getCompassStream;
  final GetDistanceBetween _getDistanceBetween;
  final GetBearingBetween _getBearingBetween;

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
    required GetDistanceBetween getDistanceBetween,
    required GetCompassStream getCompassStream,
    required GetBearingBetween getBearingBetween,
  })  : _getPositionStream = getPositionStream,
        _getActiveLocationStream = getActiveLocationStream,
        _getActiveLocation = getActiveLocation,
        _getCompassStream = getCompassStream,
        _getDistanceBetween = getDistanceBetween,
        _getBearingBetween = getBearingBetween,
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
    event.fold((failure) {
      if (failure is ActiveLocationEmptyFailure) {
        emit(state.copyWith(activeLocationStatus: ActiveLocationStatus.empty));
      } else {
        emit(
            state.copyWith(activeLocationStatus: ActiveLocationStatus.failure));
      }
    }, (activeLocation) {
      if (state.isFailure) {
        emit(state.copyWith(
            activeLocationStatus: ActiveLocationStatus.loaded,
            activeLocationPoint: activeLocation));
      } else {
        emit(state.copyWith(
            activeLocationStatus: ActiveLocationStatus.loaded,
            subText: activeLocation.name,
            activeLocationPoint: activeLocation,
            locationServiceStatus: LocationServiceStatus.loading));
      }
    });
  }

  void _positionHandler(Either<Failure, PositionEntity> event) {
    event.fold(
      (failure) {
        if (failure is LocationServiceDeniedFailure ||
            failure is LocationServiceDeniedForeverFailure) {
          emit(state.copyWith(
              locationServiceStatus: LocationServiceStatus.noPermission,
              mainText: 'Ошибка',
              subText: 'Отсутствует доступ к GPS'));
        } else if (failure is LocationServiceDisabledFailure) {
          emit(state.copyWith(
              locationServiceStatus: LocationServiceStatus.disabled,
              mainText: 'Ошибка',
              subText: 'GPS выключен'));
        } else {
          emit(state.copyWith(
              locationServiceStatus: LocationServiceStatus.unknownFailure,
              mainText: 'Ошибка',
              subText: 'Неизвестный сбой'));
        }
      },
      (position) {
        final distance = _getDistance(position);
        final accuracy = position.accuracy;
        emit(state.copyWith(
            locationServiceStatus: LocationServiceStatus.loaded,
            userLatitude: position.latitude,
            userLongitude: position.longitude,
            positionAccuracy: accuracy,
            mainText: _getDistanceString(distance),
            subText: state.activeLocationPoint.name,
            pointerArc: _getLaxity(accuracy: accuracy, distance: distance)));
      },
    );
  }

  void _compassHandler(Either<Failure, CompassEntity> event) {
    event.fold((failure) {
      emit(state.copyWith(compassStatus: CompassStatus.failure));
    }, (compass) {
      emit(state.copyWith(
        compassStatus: CompassStatus.loaded,
        angle: _getBearing(compass.north),
      ));
    });
  }

  @override
  Future<void> close() async {
    await _positionSubscription.cancel();
    await _compassSubscription.cancel();
    await _activeLocationStream.cancel();
    super.close();
  }

  int _getDistance(PositionEntity position) {
    return _getDistanceBetween(
      startLatitude: position.latitude,
      startLongitude: position.longitude,
      endLatitude: state.activeLocationPoint.latitude,
      endLongitude: state.activeLocationPoint.longitude,
    ).toInt();
  }

  String _getDistanceString(int distance) {
    if (distance < PointerConstants.minDistance) {
      return 'менее 5 м'; // ! TODO change to EN, and add '.tr()' in UI to translate
    }
    if (distance < PointerConstants.distanceThreshold) {
      return '${distance.truncate()} м';
    }
    return '${(distance / 1000).toStringAsFixed(1)} км';
  }

  double _getBearing(double compassNorth) {
    return _getBearingBetween(
          startLatitude: state.userLatitude,
          startLongitude: state.userLongitude,
          endLatitude: state.activeLocationPoint.latitude,
          endLongitude: state.activeLocationPoint.longitude,
        ) -
        (compassNorth * (pi / 180));
  }

  double _getLaxity({
    required double accuracy,
    required int distance,
  }) {
    final laxity = atan(accuracy / distance) < PointerConstants.minLaxity
        ? PointerConstants.minLaxity
        : atan(accuracy / distance);
    return distance < PointerConstants.minDistance ? pi * 2 : laxity;
  }
}
