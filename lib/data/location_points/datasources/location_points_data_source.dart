import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/location_points/models/location_point_model.dart';

abstract class LocationPointDataSource {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<LocationPointModel>> loadLocationsFromLocalStorage();
  Future<void> saveLocationsToLocalStorage(List<LocationPointModel> locations);
}

class LocationPointDataSourceImpl implements LocationPointDataSource {
  final SharedPreferences sharedPreferences;

  LocationPointDataSourceImpl({required this.sharedPreferences});

  // @override
  // Future<List<PersonModel>> getLastPersonsFromCache() {
  //   final jsonPersonsList =
  //       sharedPreferences.getStringList(CACHED_PERSONS_LIST);
  //   if (jsonPersonsList!.isNotEmpty) {
  //     print('Get Persons from Cache: ${jsonPersonsList.length}');
  //     return Future.value(jsonPersonsList
  //         .map((person) => PersonModel.fromJson(json.decode(person)))
  //         .toList());
  //   } else {
  //     throw CacheException();
  //   }
  // }

  // @override
  // Future<List<String>> personsToCache(List<PersonModel> persons) {
  //   final List<String> jsonPersonsList =
  //       persons.map((person) => json.encode(person.toJson())).toList();

  //   sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
  //   print('Persons to write Cache: ${jsonPersonsList.length}');
  //   return Future.value(jsonPersonsList);
  // }

  @override
  Future<List<LocationPointModel>> loadLocationsFromLocalStorage() {
    final jsonLocationsList =
        sharedPreferences.getString('savedLocationStorage');
    try {
      List<LocationPointModel> tempLocationList = [];
      List<String> tempList = jsonDecode(jsonLocationsList!);
      for (String element in tempList) {
        tempLocationList.add(LocationPointModel.fromJson(element));
      }
      return Future.value(tempLocationList);
    } catch (e) {
      throw LoadLocationPointsException();
    }
  }

  @override
  Future<void> saveLocationsToLocalStorage(List<LocationPointModel> locations) {
    // TODO: implement saveLocationsToLocalStorage
    throw UnimplementedError();
  }
}
