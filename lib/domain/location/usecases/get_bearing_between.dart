import 'dart:math';

import 'package:vector_math/vector_math.dart'; // ! TODO попробовать без этого пакета

class GetBearingBetween {
  double call(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
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
    return degrees(atan2(y, x));
  }
}
