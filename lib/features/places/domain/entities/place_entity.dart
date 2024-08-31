import 'package:equatable/equatable.dart';
import 'package:susanin/features/places/domain/entities/icon_entity.dart';

class PlaceEntity extends Equatable {
  const PlaceEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.creationTime,
    required this.notes,
    required this.icon,
  });

  PlaceEntity.empty()
      : id = '',
        latitude = 0,
        longitude = 0,
        name = '',
        creationTime = DateTime(0),
        notes = '',
        icon = null;

  PlaceEntity copyWith({
    double? latitude,
    double? longitude,
    String? name,
    String? notes,
    IconEntity? icon,
  }) {
    return PlaceEntity(
      id: id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      creationTime: creationTime,
      notes: notes ?? this.notes,
      icon: icon ?? this.icon,
    );
  }

  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final DateTime creationTime;
  final String notes;
  final IconEntity? icon;

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        name,
        creationTime,
        notes,
        icon,
      ];
}
