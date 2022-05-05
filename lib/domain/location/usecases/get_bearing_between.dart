import 'dart:math';

import 'package:vector_math/vector_math.dart'; // ! TODO попробовать без этого пакета

class GetBearingBetween {
  double call({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    final startLongitudeRadians = radians(startLongitude);
    final startLatitudeRadians = radians(startLatitude);
    final endLongitudeRadians = radians(endLongitude);
    final endLatitudeRadians = radians(endLatitude);

    final y = sin(endLongitudeRadians - startLongitudeRadians) *
        cos(endLatitudeRadians);
    final x = cos(startLatitudeRadians) * sin(endLatitudeRadians) -
        sin(startLatitudeRadians) *
            cos(endLatitudeRadians) *
            cos(endLongitudeRadians - startLongitudeRadians);
    return atan2(y, x);
  }
}
