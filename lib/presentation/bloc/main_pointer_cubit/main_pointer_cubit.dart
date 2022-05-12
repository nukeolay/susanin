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
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/domain/location_points/usecases/get_locations_stream.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings_stream.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  final GetPositionStream _getPositionStream;
  final GetLocationsStream _getLocationsStream;
  final GetSettingsStream _getSettingsStream;
  final GetCompassStream _getCompassStream;
  final GetDistanceBetween _getDistanceBetween;
  final GetBearingBetween _getBearingBetween;
  final GetSettings _getSettings;
  final GetLocations _getLocations;
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
    required GetSettings getSettings,
    required GetLocations getLocations,
  })  : _getPositionStream = getPositionStream,
        _getLocationsStream = getLocationsStream,
        _getSettingsStream = getSettingsStream,
        _getCompassStream = getCompassStream,
        _getDistanceBetween = getDistanceBetween,
        _getBearingBetween = getBearingBetween,
        _getSettings = getSettings,
        _getLocations = getLocations,
        super(const MainPointerState(
          compassStatus: CompassStatus.loading,
          settingsStatus: SettingsStatus.loading,
          locationServiceStatus: LocationServiceStatus.loading,
          locationsListStatus: LocationsListStatus.loading,
          positionAccuracyStatus: PositionAccuracyStatus.bad,
          positionAccuracy: 0,
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

  void _init() async {
    _settingsHandler(_getSettings());
    _locationsHandler(_getLocations());
    _compassSubscription = _getCompassStream().listen(_compassHandler);
    _positionSubscription = _getPositionStream().listen(_positionHandler);
    _settingsSubscription = _getSettingsStream().listen(_settingsHandler);
    _locationsSubscription = _getLocationsStream().listen(_locationsHandler);
  }

  void _settingsHandler(Either<Failure, SettingsEntity> event) {
    event.fold(
        (failure) =>
            emit(state.copyWith(settingsStatus: SettingsStatus.failure)),
        (settings) {
      final index = state.locations
          .indexWhere((location) => location.id == settings.activeLocationId);
      if (index != -1) {
        emit(state.copyWith(
          settingsStatus: SettingsStatus.loaded,
          locationServiceStatus: LocationServiceStatus.loading,
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
  }

  void _locationsHandler(Either<Failure, List<LocationPointEntity>> event) {
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
          pointName: locations[index].name,
          pointLatitude: locations[index].latitude,
          pointLongitude: locations[index].longitude,
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
  }

  void _positionHandler(Either<Failure, PositionEntity> event) {
    event.fold(
      (failure) {
        print('FAILURE (_positionHandler): $failure');
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
        print('POSITION (_positionHandler): $position');
        final distance = _getDistance(position);
        final accuracy = position.accuracy;
        emit(state.copyWith(
          locationServiceStatus: LocationServiceStatus.loaded,
          userLatitude: position.latitude,
          userLongitude: position.longitude,
          positionAccuracyStatus: _getPositionAccuracyStatus(accuracy),
          positionAccuracy: accuracy,
          distance: _getDistanceString(distance),
          laxity: math.atan(accuracy / distance) < minPointerWidth
              ? minPointerWidth
              : math.atan(accuracy / distance),
        ));
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
        compassAccuracy: (compass.accuracy * (math.pi / 180) * -1),
      ));
    });
  }

  @override
  Future<void> close() async {
    await _positionSubscription.cancel();
    await _compassSubscription.cancel();
    await _locationsSubscription.cancel();
    await _settingsSubscription.cancel();
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
      return 'тут';
    } else if (distance < 500) {
      return '${distance.truncate()} м';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)} км';
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
    if (accuracy < 15) {
      return PositionAccuracyStatus.good;
    } else if (accuracy < 100) {
      return PositionAccuracyStatus.poor;
    } else {
      return PositionAccuracyStatus.bad;
    }
  }
}
