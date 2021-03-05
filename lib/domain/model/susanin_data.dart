import 'dart:collection';
import 'location_point.dart';

class SusaninData {
  int _selectedLocationPointId;
  int _locationCounter;
  bool _isDarkTheme;
  ListQueue<LocationPoint> _locationList;

  SusaninData({int selectedLocationPointId, int locationCounter, bool isDarkTheme, ListQueue<LocationPoint> locationList}) {
    _selectedLocationPointId = selectedLocationPointId;
    _locationCounter = locationCounter;
    _isDarkTheme = isDarkTheme;
    _locationList = locationList;
  }

  void setSelectedLocationPointId(int selectedLocationPointId) {
    _selectedLocationPointId = selectedLocationPointId;
  }

  void setLocationCounter(int locationCounter) {
    _locationCounter = locationCounter;
  }

  void increnemtLocationCounter() {
    _locationCounter = _locationCounter + 1;
  }

  void setLocationList({ListQueue<LocationPoint> locationList}) {
    _locationList = locationList;
  }

  void setIsDarkTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
  }

  int get getSelectedLocationPointId => _selectedLocationPointId;

  int get getLocationCounter => _locationCounter;

  bool get getIsDarkTheme => _isDarkTheme;

  ListQueue<LocationPoint> get getLocationList => _locationList;

  LocationPoint get getSelectedLocationPoint => getLocationList.elementAt(_selectedLocationPointId);

  void renameLocationPoint({int locationPointId, String pointName}) {
    _locationList.elementAt(locationPointId).setPointName(pointName);
  }

  void createNewLocationPoint(double longitude, double latitude, String pointName) {
    LocationPoint locationPoint = LocationPoint.createNew(longitude: longitude, latitude: latitude, pointName: pointName);
    _locationList.add(locationPoint);
  }

  void deleteLocationPoint(int locationPointId) {
    _locationList.remove(_locationList.elementAt(locationPointId));
  }
}
