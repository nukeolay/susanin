import 'package:susanin/data/api/model/api_susanin_data.dart';
import 'package:susanin/data/api/service/service_shared_prefs_susanin_data.dart';
import 'package:susanin/domain/model/susanin_data.dart';

import 'mapper/susanin_data_mapper.dart';

class ApiUtil {
  ServiceSharedPrefsSusaninData _serviceSusaninData;

  ApiUtil(ServiceSharedPrefsSusaninData serviceSusaninData) {
    _serviceSusaninData = serviceSusaninData;
  }

  Future<SusaninData> loadSusaninData() async {
    ApiSusaninData result = await _serviceSusaninData.loadSusaninData();
    return SusaninDataMapper.fromApi(result);
  }

  void saveSusaninData(SusaninData susaninData) async { //todo проверить как работает
    ApiSusaninData result = SusaninDataMapper.toApi(susaninData);
    _serviceSusaninData.saveSusaninData(result);
  }

}