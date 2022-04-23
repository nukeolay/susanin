class LocationPointEntity {
  final double latitude;
  final double longitude;
  final String pointName;
  final DateTime creationTime;

  LocationPointEntity({
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
}
