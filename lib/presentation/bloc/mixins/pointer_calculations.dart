import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:susanin/core/constants/pointer_constants.dart';

mixin PointerCalculations {
  String getDistanceString(int distance) {
    if (distance < PointerConstants.minDistance) {
      return 'less_than_5_m'.tr();
    }
    if (distance < PointerConstants.distanceThreshold) {
      return 'distance_meters'.tr(args: [distance.truncate().toString()]);
    }
    return 'distance_kilometers'
        .tr(args: [(distance / 1000).toStringAsFixed(1)]);
  }

  double getBearing({
    required double compassNorth,
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return _getBearingBetween(
          startLatitude: startLatitude,
          startLongitude: startLongitude,
          endLatitude: endLatitude,
          endLongitude: endLongitude,
        ) -
        (compassNorth * (pi / 180));
  }

  double getLaxity({
    required double accuracy,
    required int distance,
  }) {
    final laxity = atan(accuracy / distance) < PointerConstants.minLaxity
        ? PointerConstants.minLaxity
        : atan(accuracy / distance);
    return distance < PointerConstants.minDistance ? pi * 2 : laxity;
  }

  int getDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return getDistanceBetween(
      startLatitude: startLatitude,
      startLongitude: startLongitude,
      endLatitude: endLatitude,
      endLongitude: endLongitude,
    ).toInt();
  }

  double getDistanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    const earthRadius = 6378137.0;
    final dLat = _toRadians(endLatitude - startLatitude);
    final dLon = _toRadians(endLongitude - startLongitude);
    final a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude));
    final c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  double _getBearingBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    final startLongitudeRadians = _toRadians(startLongitude);
    final startLatitudeRadians = _toRadians(startLatitude);
    final endLongitudeRadians = _toRadians(endLongitude);
    final endLatitudeRadians = _toRadians(endLatitude);

    final y = sin(endLongitudeRadians - startLongitudeRadians) *
        cos(endLatitudeRadians);
    final x = cos(startLatitudeRadians) * sin(endLatitudeRadians) -
        sin(startLatitudeRadians) *
            cos(endLatitudeRadians) *
            cos(endLongitudeRadians - startLongitudeRadians);
    return atan2(y, x);
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
