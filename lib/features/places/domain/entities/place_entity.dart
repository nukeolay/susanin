import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  const PlaceEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.creationTime,
    required this.notes,
  });

  PlaceEntity.empty()
      : id = '',
        latitude = 0,
        longitude = 0,
        name = '',
        creationTime = DateTime(0),
        notes = '';

  PlaceEntity copyWith({
    double? latitude,
    double? longitude,
    String? name,
    String? notes,
  }) {
    return PlaceEntity(
      id: id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      creationTime: creationTime,
      notes: notes ?? this.notes,
    );
  }

  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final DateTime creationTime;
  final String notes;

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        name,
        creationTime,
        notes,
      ];
}
