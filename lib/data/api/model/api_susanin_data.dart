class ApiSusaninData {
  String selectedLocationPointId;
  String locationCounter;
  String isDarkTheme;
  String locationList;

  ApiSusaninData.fromApi(Map<String, dynamic> map) {
    selectedLocationPointId = map["selectedLocationPointId"].toString();
    locationCounter = map["locationCounter"].toString();
    isDarkTheme = map["isDarkTheme"].toString();
    locationList = map["locationList"].toString();
  }

  // Map<String, dynamic> toApi() {
  //   Map<String, dynamic> map = new Map();
  //   map["selectedLocationPointId"] = selectedLocationPointId;
  //   map["locationCounter"] = locationCounter;
  //   map["isDarkTheme"] = isDarkTheme;
  //   map["locationList"] = locationList;
  //   return map;
  // }
}
