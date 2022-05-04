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
          locationServiceStatus: LocationServiceStatus.loading,
          compassStatus: CompassStatus.loading,
          locationsListStatus: LocationsListStatus.loading,
          settingsStatus: SettingsStatus.loading,
          activeLocationId: '',
          userLatitude: 0,
          userLongitude: 0,
          locations: [],
          positionAccuracy: 0,
          angle: 0,
          compassAccuracy: 0,
        )) {
    _init();
  }

  void _init() {
    _compassSubscription = _getCompassStream().listen((event) {
      event.fold(
          (failure) =>
              emit(state.copyWith(compassStatus: CompassStatus.failure)),
          (compass) => emit(state.copyWith(
                compassStatus: CompassStatus.loaded,
                angle: (compass.north * (math.pi / 180) * -1),
                compassAccuracy: (compass.accuracy * (math.pi / 180) * -1),
              )));
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
          emit(state.copyWith(
            locationServiceStatus: LocationServiceStatus.loaded,
            userLatitude: position.latitude,
            userLongitude: position.longitude,
            positionAccuracy: position.accuracy,
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
            activeLocationId: settings.activeLocationId,
          ));
        }
      });
    });

    _locationsSubscription = _getLocationsStream().listen((event) {
      event.fold(
          (failure) => emit(
              state.copyWith(locationsListStatus: LocationsListStatus.failure)),
          (locations) {
        emit(state.copyWith(
          locationsListStatus: LocationsListStatus.loaded,
          locations: locations,
        ));
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
}
