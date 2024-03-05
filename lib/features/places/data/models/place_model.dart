import 'package:susanin/features/places/domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.name,
    required super.creationTime,
  });

  factory PlaceModel.fromEntity(PlaceEntity entity) {
    return PlaceModel(
      id: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
      name: entity.name,
      creationTime: entity.creationTime,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      return PlaceModel(
        id: DateTime.now().toString(),
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        name: json['pointName'] as String,
        creationTime:
            DateTime.fromMillisecondsSinceEpoch(json['creationTime'] as int),
      );
    } else {
      return PlaceModel(
        id: json['id'] as String,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        name: json['pointName'] as String,
        creationTime:
            DateTime.fromMillisecondsSinceEpoch(json['creationTime'] as int),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': latitude,
        'longitude': longitude,
        'pointName': name,
        'creationTime': creationTime.millisecondsSinceEpoch,
      };

  PlaceEntity toEntity() => PlaceEntity(
        creationTime: creationTime,
        id: id,
        latitude: latitude,
        longitude: longitude,
        name: name,
      );
}
