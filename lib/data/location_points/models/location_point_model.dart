import 'package:susanin/domain/location_points/entities/location_point.dart';

class LocationPointModel extends LocationPointEntity {
  const LocationPointModel({
    required double latitude,
    required double longitude,
    required String pointName,
    required DateTime creationTime,
  }) : super(
          latitude: latitude,
          longitude: longitude,
          pointName: pointName,
          creationTime: creationTime,
        );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'pointName': pointName,
        'creationTime': creationTime.millisecondsSinceEpoch
      };

  factory LocationPointModel.fromJson(Map<String, dynamic> json) {
    return LocationPointModel(
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
      pointName: json["pointName"] as String,
      creationTime:
          DateTime.fromMillisecondsSinceEpoch(json["creationTime"] as int),
    );
  }

  @override
  String toString() {
    return 'LocationPointModel {lat: $latitude, lon: $longitude, name: $pointName, created at: $creationTime}';
  }
}
