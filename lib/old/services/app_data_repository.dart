import 'package:susanin/old/models/app_data.dart';

import 'data_loader.dart';

class AppDataRepository {
  DataLoader _appData = new DataLoader();

  Future<AppData> loadAllData() {
    return _appData.loadPrefs();
  }

  void saveAllData(AppData appData) {
    _appData.savePrefs(appData);
  }
}