import 'package:susanin/domain/model/susanin_data.dart';

//объявил интерфейс
abstract class SusaninRepository {
  Future<SusaninData> getSusaninData();

  Future<String> setSusaninData({SusaninData susaninData});
}
