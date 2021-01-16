class LocationPoint {
  double _latitude;
  double _longitude;
  String _pointName;
  DateTime _creationTime;

  LocationPoint({double latitude, double longitude, String pointName, DateTime creationTime}) {
    _latitude = latitude;
    _longitude = longitude;
    _pointName = pointName;
    _creationTime = creationTime;
  }

  LocationPoint.createNew({double latitude, double longitude, String pointName}) {
    _latitude = latitude;
    _longitude = longitude;
    _pointName = pointName; // TODO когда разберусь с блоком, сделать чтобы именование происходило автоматически, без передачи имени в параметр метода (сейчас не получается, потому что нужно получить из intl заготовку для имени, в зависимости от языка)
    _creationTime = DateTime.now();
  }

  Map toJson() => {'latitude': _latitude, 'longitude': _longitude, 'pointName': _pointName, 'creationTime': _creationTime.millisecondsSinceEpoch};

  factory LocationPoint.fromJson(dynamic json) {
    return LocationPoint(
        latitude: json["latitude"] as double,
        longitude: json["longitude"] as double,
        pointName: json["pointName"] as String,
        creationTime: DateTime.fromMillisecondsSinceEpoch(json["creationTime"] as int));
  }

  String toString() {
    return "latitude: $_latitude, longitude: $_longitude, pointName: $_pointName, _creationTime: $_creationTime";
  }

  double get pointLatitude => _latitude;

  double get pointLongitude => _longitude;

  String get pointName => _pointName;

  void setPointName(String pointName) {
    this._pointName = pointName;
  }

  DateTime get getCreationTime => _creationTime;
}
