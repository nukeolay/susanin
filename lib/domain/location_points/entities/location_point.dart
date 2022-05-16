import 'package:equatable/equatable.dart';

class LocationPointEntity extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final DateTime creationTime;

  const LocationPointEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.creationTime,
  });

  LocationPointEntity copyWith({
    double? latitude,
    double? longitude,
    String? name,
  }) {
    return LocationPointEntity(
      id: id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      creationTime: creationTime,
    );
  }

  @override
  String toString() {
    return 'LocationPointEntity {id: $id, lat: $latitude, lon: $longitude, name: $name, created at: $creationTime}';
  }

  @override
  List<Object?> get props => [id, latitude, longitude, name, creationTime];
}
