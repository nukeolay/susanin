import '../../domain/entities/geo_point.dart';

class GeoPointModel {
  const GeoPointModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.creationTime,
  });

  factory GeoPointModel.fromEntity(GeoPoint entity) {
    return GeoPointModel(
      id: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
      creationTime: entity.creationTime,
    );
  }

  factory GeoPointModel.fromJson(Map<String, dynamic> json) {
    return GeoPointModel(
      id: json['id'] as String? ?? DateTime.now().toString(),
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      creationTime: DateTime.fromMillisecondsSinceEpoch(
        json['creationTime'] as int,
      ),
    );
  }

  final String id;
  final double latitude;
  final double longitude;
  final DateTime creationTime;

  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': latitude,
        'longitude': longitude,
        'creationTime': creationTime.millisecondsSinceEpoch,
      };

  GeoPoint toEntity() => GeoPoint(
        creationTime: creationTime,
        id: id,
        latitude: latitude,
        longitude: longitude,
      );
}
