import 'package:susanin/data/api/api_util.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';

class SusaninDataRepository extends SusaninRepository {
  ApiUtil _apiUtil;

  SusaninDataRepository(ApiUtil apiUtil) {
    _apiUtil = apiUtil;
  }

  @override
  Future<SusaninData> getSusaninData() {
    return _apiUtil.loadSusaninData();
  }

  @override
  Future<String> setSusaninData({SusaninData susaninData}) {
    return _apiUtil.saveSusaninData(susaninData);
  }
}
