// import 'dart:collection';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:susanin/models/app_data.dart';
// import 'package:susanin/models/location_point.dart';
//
// class DataLoader {
//   static void savePrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt("savedSelectedLocationPointId", AppData.getSelectedLocationPointId);
//     await prefs.setInt("savedLocationCounter", AppData.getLocationCounter);
//     await prefs.setString("savedLocationStorage", jsonEncode(AppData.getLocationPointListStorage.toList()));
//   }
//
//   static ListQueue<LocationPoint> jsonToLocationsList(List<dynamic> json) {
//     ListQueue<LocationPoint> locationsList = new ListQueue();
//     for (dynamic element in json) {
//       locationsList.add(LocationPoint.fromJson(element));
//     }
//     return locationsList;
//   }
//
//   static void loadPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     AppData.setSelectedLocationPointId(prefs.getInt("savedSelectedLocationPointId") ?? 0);
//     AppData.setLocationCounter(prefs.getInt("savedLocationCounter") ?? 0);
//     try {
//       AppData.setLocationPointListStorage(jsonToLocationsList(jsonDecode(prefs.getString("savedLocationStorage"))));
//     } catch (e) {
//       AppData.setLocationPointListStorage(new ListQueue());
//     }
//   }
// }
