import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  const PlaceEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.creationTime,
  });

  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final DateTime creationTime;

  PlaceEntity.empty()
      : id = '',
        latitude = 0,
        longitude = 0,
        name = '',
        creationTime = DateTime(0);

  PlaceEntity copyWith({
    double? latitude,
    double? longitude,
    String? name,
  }) {
    return PlaceEntity(
      id: id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      creationTime: creationTime,
    );
  }

  @override
  String toString() {
    return 'PlaceEntity {id: $id, lat: $latitude, lon: $longitude, name: $name, created at: $creationTime}';
  }

  @override
  List<Object?> get props => [id, latitude, longitude, name, creationTime];
}
