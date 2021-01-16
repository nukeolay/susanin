import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/services/data_loader.dart';
import 'location_point.dart';
import 'dart:convert';

class AppData {
  static int _selectedLocationPointId;
  static int _locationCounter;
  static ListQueue<LocationPoint> _locationPointListStorage;

  static int get getSelectedLocationPointId => _selectedLocationPointId;

  static int get getLocationCounter => _locationCounter;

  static ListQueue<LocationPoint> get getLocationPointListStorage => _locationPointListStorage;

  static void setSelectedLocationPointId(int selectedLocationPointId) {
    _selectedLocationPointId = selectedLocationPointId;
  }

  static void setLocationCounter(int locationCounter) {
    _locationCounter = locationCounter;
  }

  static void setLocationPointListStorage(ListQueue<LocationPoint> locationPointListStorage) {
    _locationPointListStorage = locationPointListStorage;
  }





  static LocationPoint get getLocationPoint => _locationPointListStorage.elementAt(_selectedLocationPointId);

  static void setCurrentLocationAsPoint(Position currentPosition, locationName) {
    _locationPointListStorage.addFirst(
        LocationPoint(latitude: currentPosition.latitude, longitude: currentPosition.longitude, pointName: "$locationName ${++_locationCounter}"));
    _selectedLocationPointId = 0;
    DataLoader.savePrefs(); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!сохраняем данные!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  }

  static void setCurrentLocationPointName(String pointName) {
    _locationPointListStorage.elementAt(_selectedLocationPointId).setPointName(pointName);
    DataLoader.savePrefs(); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!сохраняем данные!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  }

  static void deleteLocationById(int locationPointId) {
    _locationPointListStorage.remove(_locationPointListStorage.elementAt(locationPointId));
    if (locationPointId == 0) {
      setSelectedLocationPointId(0);
    } else {
      setSelectedLocationPointId(locationPointId - 1);
    }
    DataLoader.savePrefs(); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!сохраняем данные!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  }
}
