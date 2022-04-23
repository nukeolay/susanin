import 'dart:math';

class GetDistanceBetween {
  double call({
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  }) {
    const earthRadius = 6378137.0;
    final dLat = toRadians(endLatitude - startLatitude);
    final dLon = toRadians(endLongitude - startLongitude);
    final a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(toRadians(startLatitude)) *
            cos(toRadians(endLatitude));
    final c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  double toRadians(double degree) {
    return degree * pi / 180;
  }
}
