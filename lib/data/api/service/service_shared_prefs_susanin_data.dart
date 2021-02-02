import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/data/api/model/api_susanin_data.dart';

class ServiceSharedPrefsSusaninData {
  Future<ApiSusaninData> loadSusaninData() async {
    Map<String, dynamic> mapPrefs = new Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("counter=");//todo delete
    // print(mapPrefs['locationCounter']);//todo delete
    mapPrefs['selectedLocationPointId'] = prefs.getInt("savedSelectedLocationPointId") ?? 0;
    mapPrefs['locationCounter'] = prefs.getInt("savedLocationCounter") ?? 0;
    mapPrefs['isDarkTheme'] = prefs.getBool("savedIsDarkTheme") ?? false;
    mapPrefs['locationList'] = prefs.getString("savedLocationStorage");
    return ApiSusaninData.fromApi(mapPrefs);
  }

  void saveSusaninData(ApiSusaninData apiSusaninData) async { //todo проверить как работает
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("savedSelectedLocationPointId", int.parse(apiSusaninData.selectedLocationPointId));
    await prefs.setInt("savedLocationCounter", int.parse(apiSusaninData.locationCounter));
    await prefs.setBool("savedIsDarkTheme", apiSusaninData.isDarkTheme == "true" ? true : false);
    await prefs.setString("savedLocationStorage", apiSusaninData.locationList);
  }
}