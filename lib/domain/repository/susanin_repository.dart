import 'dart:collection';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';

//объявил интерфейс
abstract class SusaninRepository {
  // Future<int> getSelectedLocationPointId();
  //
  // Future<int> getLocationCounter();
  //
  // Future<bool> getIsDarkTheme();
  //
  // Future<ListQueue<LocationPoint>> getLocationList();

  Future<SusaninData> getSusaninData();

  // void setSelectedLocationPointId({int selectedLocationPointId});
  //
  // void setLocationCounter({int locationCounter});
  //
  // void setIsDarkTheme({bool isDarkTheme});
  //
  // void setLocationList({ListQueue<LocationPoint> locationList()});

  void setSusaninData({SusaninData susaninData});
}
