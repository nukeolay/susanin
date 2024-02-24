import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/features/places/data/models/place_model.dart';

abstract class PlacesService {
  List<PlaceModel> load();
  Future<void> save(List<PlaceModel> places);
}

class PlacesServiceImpl implements PlacesService {
  const PlacesServiceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  static const _pointsKey = 'savedLocationStorage';

  @override
  List<PlaceModel> load() {
    final jsonPoints = sharedPreferences.getString(_pointsKey);
    if (jsonPoints == null) {
      return const [];
    }
    try {
      final List<dynamic> json = jsonDecode(jsonPoints);
      final points =
          json.map((element) => PlaceModel.fromJson(element)).toList();
      return points;
    } catch (error) {
      throw LoadLocationPointsException();
    }
  }

  @override
  Future<void> save(List<PlaceModel> places) async {
    final jsonLocations = json.encode(places);
    await sharedPreferences.setString(_pointsKey, jsonLocations);
  }
}
