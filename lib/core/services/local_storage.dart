import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  const LocalStorage();
  Future<void> save({required String key, required String data});
  Future<String?> load({required String key});
  Future<void> clear({required String key});
  Future<void> clearAll();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl();
  SharedPreferences? _sharedPreferences;

  @override
  Future<void> save({required String key, required String data}) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    await _sharedPreferences?.setString(key, data);
  }

  @override
  Future<void> clear({required String key}) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    await _sharedPreferences?.remove(key);
  }

  @override
  Future<void> clearAll() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    await _sharedPreferences?.clear();
  }

  @override
  Future<String?> load({required String key}) async {
    try {
      _sharedPreferences ??= await SharedPreferences.getInstance();
      final loadedData = _sharedPreferences?.getString(key);
      return loadedData;
    } catch (error) {
      return null;
    }
  }
}
