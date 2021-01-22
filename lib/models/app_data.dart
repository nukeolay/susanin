import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/services/data_loader.dart';
import 'location_point.dart';
import 'dart:convert';

class AppData {
  int _selectedLocationPointId;
  int _locationCounter;
  ListQueue<LocationPoint> _locationPointListStorage;

  AppData ({int selectedLocationPointId, int locationCounter, ListQueue<LocationPoint> locationPointListStorage}) {
    _selectedLocationPointId = selectedLocationPointId;
    _locationCounter = locationCounter;
    _locationPointListStorage = locationPointListStorage;
  }

  int get getSelectedLocationPointId => _selectedLocationPointId;

  int get getLocationCounter => _locationCounter;

  ListQueue<LocationPoint> get getLocationPointListStorage => _locationPointListStorage;

  void setSelectedLocationPointId(int selectedLocationPointId) {
    _selectedLocationPointId = selectedLocationPointId;
  }

  void setLocationCounter(int locationCounter) {
    _locationCounter = locationCounter;
  }

  void setLocationPointListStorage(ListQueue<LocationPoint> locationPointListStorage) {
    _locationPointListStorage = locationPointListStorage;
  }

  // TODO проверить для чего нужны методы ниже. Перенести в отдельный класс DataEditor

  LocationPoint get getLocationPoint => _locationPointListStorage.elementAt(_selectedLocationPointId);

  void setCurrentLocationAsPoint(Position currentPosition, locationName) {
    _locationPointListStorage.addFirst(
        LocationPoint(latitude: currentPosition.latitude, longitude: currentPosition.longitude, pointName: "$locationName ${++_locationCounter}"));
    _selectedLocationPointId = 0;
    //DataLoader.savePrefs(); TODO не забыть сохранить !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  }

  void setCurrentLocationPointName(String pointName) {
    _locationPointListStorage.elementAt(_selectedLocationPointId).setPointName(pointName);
    //DataLoader.savePrefs(); TODO не забыть сохранить !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  }

  void deleteLocationById(int locationPointId) {
    _locationPointListStorage.remove(_locationPointListStorage.elementAt(locationPointId));
    if (locationPointId == 0) {
      setSelectedLocationPointId(0);
    } else {
      setSelectedLocationPointId(locationPointId - 1);
    }
    //DataLoader.savePrefs(); TODO не забыть сохранить !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  }
}
