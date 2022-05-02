import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/location_points/models/location_point_model.dart';

abstract class LocationsDataSource {
  List<LocationPointModel> load();
  Future<void> save(List<LocationPointModel> locations);
}

class LocationsDataSourceImpl implements LocationsDataSource {
  final SharedPreferences sharedPreferences;
  static const locationsKey = 'savedLocations';

  const LocationsDataSourceImpl(this.sharedPreferences);

  @override
  List<LocationPointModel> load() {
    final jsonLocations = sharedPreferences.getString(locationsKey);
    if (jsonLocations == null) {
      return const [];
    } else {
      try {
        final List<dynamic> json = jsonDecode(jsonLocations);
        final List<LocationPointModel> locations = json
            .map((element) => LocationPointModel.fromJson(element))
            .toList();
        return locations;
      } catch (error) {
        throw LoadLocationPointsException();
      }
    }
  }

  @override
  Future<void> save(List<LocationPointModel> locations) async {
    final String jsonLocations = json.encode(locations);
    await sharedPreferences.setString(locationsKey, jsonLocations);
  }
}
