import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/location_points/models/location_point_model.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

abstract class LocationsDataSource {
  Future<List<LocationPointModel>> loadLocations();
  Future<void> saveLocations(List<LocationPointEntity> locations);
}

class LocationsDataSourceImpl implements LocationsDataSource {
  final SharedPreferences sharedPreferences;
  static const locationsKey = 'savedLocations';

  const LocationsDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<LocationPointModel>> loadLocations() async {
    final jsonLocations = sharedPreferences.getString(locationsKey);
    if (jsonLocations == null) {
      return Future.value(const []);
    } else {
      try {
        final List<dynamic> json = jsonDecode(jsonLocations);
        final List<LocationPointModel> locations = json
            .map((element) => LocationPointModel.fromJson(element))
            .toList();
        return Future.value(locations);
      } catch (error) {
        throw LoadLocationPointsException();
      }
    }
  }

  @override
  Future<void> saveLocations(List<LocationPointEntity> locations) async {
    final String jsonLocations = json.encode(locations
        .map((locationEntity) => LocationPointModel(
              id: locationEntity.id,
              latitude: locationEntity.latitude,
              longitude: locationEntity.longitude,
              name: locationEntity.name,
              creationTime: locationEntity.creationTime,
            ))
        .toList());
    await sharedPreferences.setString(locationsKey, jsonLocations);
  }
}
