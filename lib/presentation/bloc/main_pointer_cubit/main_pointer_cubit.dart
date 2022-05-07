import 'dart:async';
import 'dart:math' as math;

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_bearing_between.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/usecases/get_locations_stream.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings_stream.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  final GetPositionStream _getPositionStream;
  final GetLocationsStream _getLocationsStream;
  final GetSettingsStream _getSettingsStream;
  final GetCompassStream _getCompassStream;
  final GetDistanceBetween _getDistanceBetween;
  final GetBearingBetween _getBearingBetween;
  final double minPointerWidth = 0.4;
  late final StreamSubscription<Either<Failure, PositionEntity>>
      _positionSubscription;
  late final StreamSubscription<Either<Failure, List<LocationPointEntity>>>
      _locationsSubscription;
  late final StreamSubscription<Either<Failure, SettingsEntity>>
      _settingsSubscription;
  late final StreamSubscription<Either<Failure, CompassEntity>>
      _compassSubscription;

  MainPointerCubit({
    required GetPositionStream getPositionStream,
    required GetLocationsStream getLocationsStream,
    required GetSettingsStream getSettingsStream,
    required GetDistanceBetween getDistanceBetween,
    required GetCompassStream getCompassStream,
    required GetBearingBetween getBearingBetween,
  })  : _getPositionStream = getPositionStream,
        _getLocationsStream = getLocationsStream,
        _getSettingsStream = getSettingsStream,
        _getCompassStream = getCompassStream,
        _getDistanceBetween = getDistanceBetween,
        _getBearingBetween = getBearingBetween,
        super(const MainPointerState(
          compassStatus: CompassStatus.loading,
          settingsStatus: SettingsStatus.loading,
          locationServiceStatus: LocationServiceStatus.loading,
          locationsListStatus: LocationsListStatus.loading,
          positionAccuracyStatus: PositionAccuracyStatus.bad,
          pointName: '',
          pointLatitude: 0,
          pointLongitude: 0,
          userLongitude: 0,
          userLatitude: 0,
          activeLocationId: '',
          angle: 0,
          compassAccuracy: 0,
          distance: '',
          laxity: 0,
          locations: [],
        )) {
    _init();
  }

  void _init() {
    _compassSubscription = _getCompassStream().listen((event) {
      event.fold((failure) {
        emit(state.copyWith(compassStatus: CompassStatus.failure));
      }, (compass) {
        emit(state.copyWith(
          compassStatus: CompassStatus.loaded,
          angle: _getBearing(compass.north),
          compassAccuracy: (compass.accuracy * (math.pi / 180) * -1),
        ));
      });
    });

    _positionSubscription = _getPositionStream().listen((event) {
      event.fold(
        (failure) {
          if (failure is LocationServiceDeniedFailure ||
              failure is LocationServiceDeniedForeverFailure) {
            emit(state.copyWith(
                locationServiceStatus: LocationServiceStatus.noPermission));
          } else if (failure is LocationServiceDisabledFailure) {
            emit(state.copyWith(
                locationServiceStatus: LocationServiceStatus.disabled));
          } else {
            emit(state.copyWith(
                locationServiceStatus: LocationServiceStatus.unknownFailure));
          }
        },
        (position) {
          final distance = _getDistance(position);
          final accuracy = position.accuracy;
          emit(state.copyWith(
            locationServiceStatus: LocationServiceStatus.loaded,
            userLatitude: position.latitude,
            userLongitude: position.longitude,
            positionAccuracyStatus: _getPositionAccuracyStatus(accuracy),
            distance: _getDistanceString(distance),
            laxity: math.atan(accuracy / distance) < minPointerWidth
                ? minPointerWidth
                : math.atan(accuracy / distance),
          ));
        },
      );
    });

    _settingsSubscription = _getSettingsStream().listen((event) {
      event.fold(
          (failure) =>
              emit(state.copyWith(settingsStatus: SettingsStatus.failure)),
          (settings) {
        final index = state.locations
            .indexWhere((location) => location.id == settings.activeLocationId);
        if (index != -1) {
          emit(state.copyWith(
            settingsStatus: SettingsStatus.loaded,
            locationServiceStatus: LocationServiceStatus
                .loading, // чтобы до определения следующей геопозиции не показывались координаты
            activeLocationId: settings.activeLocationId,
            pointName: state.locations[index].name,
            pointLatitude: state.locations[index].latitude,
            pointLongitude: state.locations[index].longitude,
          ));
        } else {
          emit(state.copyWith(
            settingsStatus: SettingsStatus.loaded,
            locationServiceStatus: LocationServiceStatus.loading,
            activeLocationId: settings.activeLocationId,
            pointName: '',
            pointLatitude: 0,
            pointLongitude: 0,
          ));
        }
      });
    });

    _locationsSubscription = _getLocationsStream().listen((event) {
      event.fold(
          (failure) => emit(
              state.copyWith(locationsListStatus: LocationsListStatus.failure)),
          (locations) {
        final index = locations
            .indexWhere((location) => location.id == state.activeLocationId);
        if (index != -1) {
          emit(state.copyWith(
            locationsListStatus: LocationsListStatus.loaded,
            locations: locations,
            pointName: state.locations[index].name,
            pointLatitude: state.locations[index].latitude,
            pointLongitude: state.locations[index].longitude,
          ));
        } else {
          emit(state.copyWith(
            locationsListStatus: LocationsListStatus.loaded,
            locations: locations,
            pointName: '',
            pointLatitude: 0,
            pointLongitude: 0,
          ));
        }
      });
    });
  }

  @override
  Future<void> close() async {
    _positionSubscription.cancel();
    _compassSubscription.cancel();
    _locationsSubscription.cancel();
    _settingsSubscription.cancel();
    super.close();
  }

  int _getDistance(PositionEntity position) {
    return _getDistanceBetween(
      startLatitude: position.latitude,
      startLongitude: position.longitude,
      endLatitude: state.pointLatitude,
      endLongitude: state.pointLongitude,
    ).toInt();
  }

  String _getDistanceString(int distance) {
    if (distance < 5) {
      return 'на месте';
    } else if (distance < 500) {
      return '${distance.truncate()} m';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)} km';
    }
  }

  double _getBearing(double compassNorth) {
    return _getBearingBetween(
          startLatitude: state.userLatitude,
          startLongitude: state.userLongitude,
          endLatitude: state.pointLatitude,
          endLongitude: state.pointLongitude,
        ) +
        (compassNorth * (math.pi / 180) * -1);
  }

  PositionAccuracyStatus _getPositionAccuracyStatus(double accuracy) {
    if (accuracy < 10) {
      return PositionAccuracyStatus.fine;
    } else if (accuracy < 20) {
      return PositionAccuracyStatus.good;
    } else if (accuracy < 100) {
      return PositionAccuracyStatus.poor;
    } else {
      return PositionAccuracyStatus.bad;
    }
  }
}
