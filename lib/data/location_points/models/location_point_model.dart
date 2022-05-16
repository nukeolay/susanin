import 'package:susanin/domain/location_points/entities/location_point.dart';

class LocationPointModel extends LocationPointEntity {
  const LocationPointModel({
    required String id,
    required double latitude,
    required double longitude,
    required String name,
    required DateTime creationTime,
  }) : super(
          id: id,
          latitude: latitude,
          longitude: longitude,
          name: name,
          creationTime: creationTime,
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': latitude,
        'longitude': longitude,
        'pointName': name,
        'creationTime': creationTime.millisecondsSinceEpoch
      };

  factory LocationPointModel.fromJson(Map<String, dynamic> json) {
    return LocationPointModel(
      id: json["id"] as String,
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
      name: json["pointName"] as String,
      creationTime:
          DateTime.fromMillisecondsSinceEpoch(json["creationTime"] as int),
    );
  }
}
