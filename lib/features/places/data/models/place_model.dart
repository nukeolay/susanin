import 'package:susanin/features/places/domain/entities/place_entity.dart';

class PlaceModel {
  const PlaceModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.notes,
    required this.name,
    required this.creationTime,
  });

  factory PlaceModel.fromEntity(PlaceEntity entity) {
    return PlaceModel(
      id: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
      notes: entity.notes,
      name: entity.name,
      creationTime: entity.creationTime,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String? ?? DateTime.now().toString(),
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      notes: json['notes'] as String?,
      name: json['pointName'] as String,
      creationTime: DateTime.fromMillisecondsSinceEpoch(
        json['creationTime'] as int,
      ),
    );
  }

  final String id;
  final double latitude;
  final double longitude;
  final String? notes;
  final String name;
  final DateTime creationTime;

  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': latitude,
        'longitude': longitude,
        'pointName': name,
        'notes': notes,
        'creationTime': creationTime.millisecondsSinceEpoch,
      };

  PlaceEntity toEntity() => PlaceEntity(
        creationTime: creationTime,
        id: id,
        latitude: latitude,
        longitude: longitude,
        notes: notes ?? '',
        name: name,
      );
}
