import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class GeoPoint extends Equatable {
  const GeoPoint({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.creationTime,
  });

  factory GeoPoint.fromCoordinates({
    required double latitude,
    required double longitude,
  }) => GeoPoint(
    id: Uuid().v4(),
    latitude: latitude,
    longitude: longitude,
    creationTime: DateTime.now(),
  );

  final String id;
  final double latitude;
  final double longitude;
  final DateTime creationTime;

  @override
  List<Object?> get props => [id, latitude, longitude, creationTime];
}
