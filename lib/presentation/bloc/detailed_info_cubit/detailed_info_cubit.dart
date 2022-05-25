import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_state.dart';

class DetailedInfoCubit extends Cubit<DetailedInfoState> {
  final GetPositionStream _getPositionStream;
  final GetCompassStream _getCompassStream;
  final GetDistanceBetween _getDistanceBetween;
  final GetBearingBetween _getBearingBetween;

  late final StreamSubscription<Either<Failure, PositionEntity>>
      _positionSubscription;
  late final StreamSubscription<Either<Failure, CompassEntity>>
      _compassSubscription;

  DetailedInfoCubit({
    required GetPositionStream getPositionStream,
    required GetDistanceBetween getDistanceBetween,
    required GetCompassStream getCompassStream,
    required GetBearingBetween getBearingBetween,
  })  : _getPositionStream = getPositionStream,
        _getCompassStream = getCompassStream,
        _getDistanceBetween = getDistanceBetween,
        _getBearingBetween = getBearingBetween,
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
      locationLongitude: activeLocation.longitude,
    ));
  }

  void _init() async {
    _compassSubscription = _getCompassStream().listen(_compassHandler);
    _positionSubscription = _getPositionStream().listen(_positionHandler);
  }

  void _positionHandler(Either<Failure, PositionEntity> event) {
    event.fold(
      (failure) {
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
      },
      (position) {
        final distance = _getDistance(position);
        final accuracy = position.accuracy;
        emit(state.copyWith(
            locationServiceStatus: LocationServiceStatus.loaded,
            userLatitude: position.latitude,
            userLongitude: position.longitude,
            positionAccuracy: accuracy,
            distance: _getDistanceString(distance),
            pointerArc: _getLaxity(accuracy: accuracy, distance: distance)));
      },
    );
  }

  void _compassHandler(Either<Failure, CompassEntity> event) {
    event.fold((failure) {
      emit(state.copyWith(hasCompass: false));
    }, (compass) {
      emit(state.copyWith(hasCompass: true, angle: _getBearing(compass.north)));
    });
  }

  @override
  Future<void> close() async {
    await _positionSubscription.cancel();
    await _compassSubscription.cancel();
    super.close();
  }

  int _getDistance(PositionEntity position) {
    return _getDistanceBetween(
      startLatitude: position.latitude,
      startLongitude: position.longitude,
      endLatitude: state.locationLatitude,
      endLongitude: state.locationLongitude,
    ).toInt();
  }

  String _getDistanceString(int distance) {
    if (distance < PointerConstants.minDistance) {
      return 'less_than_5_m'.tr();
    }
    if (distance < PointerConstants.distanceThreshold) {
      return 'distance_meters'.tr(args: [distance.truncate().toString()]);
    }
    return 'distance_kilometers'
        .tr(args: [(distance / 1000).toStringAsFixed(1)]);
  }

  double _getBearing(double compassNorth) {
    return _getBearingBetween(
          startLatitude: state.userLatitude,
          startLongitude: state.userLongitude,
          endLatitude: state.locationLatitude,
          endLongitude: state.locationLongitude,
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
