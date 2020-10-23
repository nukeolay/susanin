import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_point.dart';
import 'dart:convert';

class ApplicationData extends ChangeNotifier {
  static final ApplicationData _applicationData = ApplicationData._internal();
  int _selectedLocationPointId;
  ListQueue<LocationPoint> _locationPointListStorage;
  int _locationCounter;
  bool loaded = false;
  bool shortAccuracyForm = true;
  bool shortCompassForm = true;

  savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        "savedSelectedLocationPointId", _selectedLocationPointId);
    await prefs.setInt("savedLocationCounter", _locationCounter);
    await prefs.setString(
        "savedLocationStorage", jsonEncode(_locationPointListStorage.toList()));
  }

  void loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedLocationPointId =
    (prefs.getInt("savedSelectedLocationPointId") ?? 0);
    _locationCounter = (prefs.getInt("savedLocationCounter") ?? 0);
    try {
      _locationPointListStorage = jsonToLocationsList(
          jsonDecode(prefs.getString("savedLocationStorage")));
      loaded = true;
    } catch (e) {
      _locationPointListStorage = new ListQueue();
      loaded = true;
    }
    notifyListeners();
  }

  ListQueue<LocationPoint> jsonToLocationsList(List<dynamic> json) {
    ListQueue<LocationPoint> locationsList = new ListQueue();
    for (dynamic element in json) {
      locationsList.add(LocationPoint.fromJson(element));
    }
    return locationsList;
  }

  ApplicationData._internal();

  factory ApplicationData() {
    return _applicationData;
  }

  LocationPoint get getLocationPoint {
    return _locationPointListStorage.elementAt(_selectedLocationPointId);
  }

  int get getSelectedLocationPointId => _selectedLocationPointId;

  void setSelectLocationById(int pointId) {
    _selectedLocationPointId = pointId;
    savePrefs(); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!сохраняем данные!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    notifyListeners();
  }

  void setCurrentLocationAsPoint(Position currentPosition, locationName) {
    _locationPointListStorage.addFirst(LocationPoint(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
        pointName: "$locationName ${++_locationCounter}"));
    _selectedLocationPointId = 0;
    savePrefs(); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!сохраняем данные!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    notifyListeners();
  }

  void setCurrentLocationPointName(String pointName) {
    _locationPointListStorage
        .elementAt(_selectedLocationPointId)
        .setPointName(pointName);
    savePrefs(); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!сохраняем данные!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    notifyListeners();
  }

  void deleteLocationById(int locationPointId) {
    _locationPointListStorage
        .remove(_locationPointListStorage.elementAt(locationPointId));
    if (locationPointId == 0) {
      setSelectLocationById(0);
    } else {
      setSelectLocationById(locationPointId - 1);
    }
  }

  ListQueue<LocationPoint> get getLocationPointListStorage =>
      _locationPointListStorage;

  Color getSelectedColor(bool arg) {
    if (arg)
      return Colors.green;
    else
      return Colors.grey;
  }
  Color getAccuracyMarkerColor(double accuracy) {
    if (accuracy >= 20) {
      return Colors.red;
    }
    else if (accuracy >= 15) {
      return Colors.orangeAccent[400];
    }
    else if (accuracy >= 9) {
      return Colors.yellowAccent[400];
    }
    else return Colors.green;
  }

  void switchShortAccuracyForm() {
    shortAccuracyForm = !shortAccuracyForm;
  }

  void switchShortCompassForm() {
    shortCompassForm = !shortCompassForm;
  }
}