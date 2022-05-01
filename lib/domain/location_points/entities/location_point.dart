import 'package:equatable/equatable.dart';

class LocationPointEntity extends Equatable {
  final double latitude;
  final double longitude;
  final String pointName;
  final DateTime creationTime;

  const LocationPointEntity({
    required this.latitude,
    required this.longitude,
    required this.pointName,
    required this.creationTime,
  });

  LocationPointEntity copyWith(
      {double? latitude,
      double? longitude,
      String? pointName,
      DateTime? creationTime}) {
    return LocationPointEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pointName: pointName ?? this.pointName,
      creationTime: creationTime ?? this.creationTime,
    );
  }

  @override
  String toString() {
    return 'LocationPointEntity {lat: $latitude, lon: $longitude, name: $pointName, created at: $creationTime}';
  }

  @override
  List<Object?> get props => [latitude, longitude, pointName, creationTime];
}
