class PositionGeolocatorModel {
  final int longitude;
  final int latitude;
  final int accuracy;

  PositionGeolocatorModel({
    required this.longitude,
    required this.latitude,
    required this.accuracy,
  });

  // PositionGeolocatorModel.fromJson(Map<String, dynamic> json)
  //     : singleFlips = json['singleFlips'] as int,
  //       solutionsNumber = json['solutionsNumber'] as int;

  // Map<String, dynamic> toJson() => {
  //       'singleFlips': singleFlips,
  //       'solutionsNumber': solutionsNumber,
  //     };
}
