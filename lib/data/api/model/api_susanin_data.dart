class ApiSusaninData {
  String selectedLocationPointId;
  String locationCounter;
  String isDarkTheme;
  String isFirstTime;
  String locationList;

  ApiSusaninData.fromApi(Map<String, dynamic> map) {
    selectedLocationPointId = map["selectedLocationPointId"].toString();
    locationCounter = map["locationCounter"].toString();
    isDarkTheme = map["isDarkTheme"].toString();
    isFirstTime = map["isFirstTime"].toString();
    locationList = map["locationList"].toString();
  }
}
