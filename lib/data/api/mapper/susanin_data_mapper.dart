import 'dart:collection';
import 'dart:convert';

import 'package:susanin/data/api/model/api_location_point.dart';
import 'package:susanin/data/api/model/api_susanin_data.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';

import 'location_point_mapper.dart';

class SusaninDataMapper {
  static SusaninData fromApi(ApiSusaninData apiSusaninData) {
    return SusaninData(
        selectedLocationPointId: int.tryParse(apiSusaninData.selectedLocationPointId) ?? 0,
        locationCounter: int.tryParse(apiSusaninData.locationCounter) ?? 0,
        isDarkTheme: apiSusaninData.isDarkTheme == "true" ? true : false,
        locationList: StringToListQueue(apiSusaninData.locationList));
  }

  static ListQueue<LocationPoint> StringToListQueue(String savedLocationStorage) {
    ListQueue<LocationPoint> tempLocationList = new ListQueue();
    try {
      List<dynamic> tempList = jsonDecode(savedLocationStorage);
      for (dynamic element in tempList) {
        tempLocationList.add(LocationPointMapper.fromApi(ApiLocationPoint.fromApi(element)));
      }
      return tempLocationList;
    } catch (e) {
      return tempLocationList;
    }
  }

  static String ListQueueToString(ListQueue<LocationPoint> locationList) {
    List<LocationPoint> tempLocationList = <LocationPoint>[];
    for (dynamic element in locationList) {
      tempLocationList.add(element);
    }
    String locationListString;
    try {
      locationListString = jsonEncode(tempLocationList);
      return locationListString;
    } catch (e) {
      return locationListString;
    }
  }

  static ApiSusaninData toApi(SusaninData susaninData) {
    Map<String, dynamic> map = new Map();
    map['selectedLocationPointId'] = susaninData.getSelectedLocationPointId;
    map['locationCounter'] = susaninData.getLocationCounter;
    map['isDarkTheme'] = susaninData.getIsDarkTheme;
    map['locationList'] = ListQueueToString(susaninData.getLocationList);
    return ApiSusaninData.fromApi(map);
  }
}
