import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/data/api/model/api_susanin_data.dart';

class ServiceSharedPrefsSusaninData {
  Future<ApiSusaninData> loadSusaninData() async {
    Map<String, dynamic> mapPrefs = new Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mapPrefs['selectedLocationPointId'] = prefs.getInt("savedSelectedLocationPointId") ?? 0;
    mapPrefs['locationCounter'] = prefs.getInt("savedLocationCounter") ?? 0;
    mapPrefs['isDarkTheme'] = prefs.getBool("savedIsDarkTheme") ?? false;
    mapPrefs['isFirstTime'] = prefs.getBool("savedIsFirstTime") ?? true;
    mapPrefs['locationList'] = prefs.getString("savedLocationStorage");
    //print("loaded from prefs"); //todo uncomment in debug
    return ApiSusaninData.fromApi(mapPrefs);
  }

  Future<String> saveSusaninData(ApiSusaninData apiSusaninData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("savedSelectedLocationPointId", int.parse(apiSusaninData.selectedLocationPointId));
    await prefs.setInt("savedLocationCounter", int.parse(apiSusaninData.locationCounter));
    await prefs.setBool("savedIsDarkTheme", apiSusaninData.isDarkTheme == "true" ? true : false);
    await prefs.setBool("savedIsFirstTime", apiSusaninData.isFirstTime == "true" ? true : false);
    await prefs.setString("savedLocationStorage", apiSusaninData.locationList);
    //print("saved to prefs"); //todo uncomment in debug
    return "saved";
  }
}
