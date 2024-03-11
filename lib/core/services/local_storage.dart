import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<void> save({required String key, required String data});
  Future<String?> load({required String key});
  Future<void> clear({required String key});
  Future<void> clearAll();
}

class LocalStorageImpl implements LocalStorage {
  const LocalStorageImpl(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  @override
  Future<void> save({required String key, required String data}) async {
    await _sharedPreferences.setString(key, data);
  }

  @override
  Future<void> clear({required String key}) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }

  @override
  Future<String?> load({required String key}) async {
    try {
      final loadedData = _sharedPreferences.getString(key);
      return loadedData;
    } catch (error) {
      return null;
    }
  }
}
