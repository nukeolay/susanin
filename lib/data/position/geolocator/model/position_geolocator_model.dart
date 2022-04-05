import 'package:geolocator/geolocator.dart';

class PositionGeolocatorModel {
  final double longitude;
  final double latitude;
  final double accuracy;

  PositionGeolocatorModel({
    required this.longitude,
    required this.latitude,
    required this.accuracy,
  });

  PositionGeolocatorModel.fromGeolocator(Position geolocatorPosition)
      : longitude = geolocatorPosition.longitude,
        latitude = geolocatorPosition.latitude,
        accuracy = geolocatorPosition.accuracy;
}
