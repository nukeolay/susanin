import 'dart:math';

class GetBearingBetween {
  double call({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    final startLongitudeRadians = toRadians(startLongitude);
    final startLatitudeRadians = toRadians(startLatitude);
    final endLongitudeRadians = toRadians(endLongitude);
    final endLatitudeRadians = toRadians(endLatitude);

    final y = sin(endLongitudeRadians - startLongitudeRadians) *
        cos(endLatitudeRadians);
    final x = cos(startLatitudeRadians) * sin(endLatitudeRadians) -
        sin(startLatitudeRadians) *
            cos(endLatitudeRadians) *
            cos(endLongitudeRadians - startLongitudeRadians);
    return atan2(y, x);
  }

  double toRadians(double degree) {
    return degree * pi / 180;
  }
}
