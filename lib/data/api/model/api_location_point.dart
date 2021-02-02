class ApiLocationPoint {
  double latitude;
  double longitude;
  String pointName;
  int creationTime;

  ApiLocationPoint.fromApi(Map<String, dynamic> map) {
    latitude = map["latitude"] as double;
    longitude = map["longitude"] as double;
    pointName = map["pointName"] as String;
    creationTime = map["creationTime"] as int;
  }

  Map toApi() => {'latitude': latitude, 'longitude': longitude, 'pointName': pointName, 'creationTime': creationTime};
}
