import 'dart:math';

import '../constants/pointer_constants.dart';
import '../extensions/extensions.dart';

mixin PointerCalculations {
  double get compassNorth;
  double get userLatitude;
  double get userLongitude;
  double get locationLatitude;
  double get locationLongitude;
  double get accuracy;

  double get distance {
    const earthRadius = 6378137.0;
    final dLat = (locationLatitude - userLatitude).toRadians();
    final dLon = (locationLongitude - userLongitude).toRadians();
    final a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(userLatitude.toRadians()) *
            cos(locationLatitude.toRadians());
    final c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  double get bearing =>
      _getBearingBetween(
        startLatitude: userLatitude,
        startLongitude: userLongitude,
        endLatitude: locationLatitude,
        endLongitude: locationLongitude,
      ) -
      (compassNorth * (pi / 180));

  double _getBearingBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    final startLongitudeRadians = startLongitude.toRadians();
    final startLatitudeRadians = startLatitude.toRadians();
    final endLongitudeRadians = endLongitude.toRadians();
    final endLatitudeRadians = endLatitude.toRadians();

    final y = sin(endLongitudeRadians - startLongitudeRadians) *
        cos(endLatitudeRadians);
    final x = cos(startLatitudeRadians) * sin(endLatitudeRadians) -
        sin(startLatitudeRadians) *
            cos(endLatitudeRadians) *
            cos(endLongitudeRadians - startLongitudeRadians);
    return atan2(y, x);
  }

  double get pointerArc {
    final laxity = atan(accuracy / distance) < PointerConstants.minLaxity
        ? PointerConstants.minLaxity
        : atan(accuracy / distance);
    return distance < PointerConstants.minDistance ? pi * 2 : laxity;
  }
}
