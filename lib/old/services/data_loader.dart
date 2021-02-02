import 'dart:collection';
import 'dart:convert';
import 'package:susanin/old/models/app_data.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataLoader {
  Future<AppData> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int selectedLocaitionPointId = prefs.getInt("savedSelectedLocationPointId") ?? 0;
    int locationCounter = prefs.getInt("savedLocationCounter") ?? 0;
    ListQueue<LocationPoint> locationList = new ListQueue();
    try {
      List<dynamic> json = jsonDecode(prefs.getString("savedLocationStorage"));
      for (dynamic element in json) {
        locationList.add(LocationPoint.fromJson(element));
      }
    } catch (e) {}
    AppData appData = AppData(selectedLocationPointId: selectedLocaitionPointId, locationCounter: locationCounter, locationPointListStorage: locationList);
    return appData;
  }

  void savePrefs(AppData appData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("savedSelectedLocationPointId", appData.getSelectedLocationPointId);
    await prefs.setInt("savedLocationCounter", appData.getLocationCounter);
    await prefs.setString("savedLocationStorage", jsonEncode(appData.getLocationPointListStorage.toList()));
  }



}
