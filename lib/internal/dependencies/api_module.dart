import 'package:susanin/data/api/api_util.dart';
import 'package:susanin/data/api/service/service_shared_prefs_susanin_data.dart';

class ApiModule {
  static ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(new ServiceSharedPrefsSusaninData());
    }
    return _apiUtil;
  }
}