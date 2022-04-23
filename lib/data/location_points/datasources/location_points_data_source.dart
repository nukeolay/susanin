import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/location_points/models/location_point_model.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

abstract class LocationPointDataSource {
  Future<List<LocationPointModel>> loadLocations();
  Future<void> saveLocations(List<LocationPointEntity> locations);
}

class LocationPointDataSourceImpl implements LocationPointDataSource {
  final SharedPreferences sharedPreferences;
  static const locationsKey = 'savedLocationStorage';
  
  const LocationPointDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<LocationPointModel>> loadLocations() async {
    final jsonLocations = sharedPreferences.getString(locationsKey);
    try {
      final List<dynamic> json = jsonDecode(jsonLocations!);
      final List<LocationPointModel> locations =
          json.map((element) => LocationPointModel.fromJson(element)).toList();
      return Future.value(locations);
    } catch (error) {
      throw LoadLocationPointsException();
    }
  }

  @override
  Future<void> saveLocations(
      List<LocationPointEntity> locations) async {
    final String jsonLocations = json.encode(locations
        .map((locationEntity) => LocationPointModel(
              latitude: locationEntity.latitude,
              longitude: locationEntity.longitude,
              pointName: locationEntity.pointName,
              creationTime: locationEntity.creationTime,
            ))
        .toList());
    await sharedPreferences.setString(locationsKey, jsonLocations);
  }
}
