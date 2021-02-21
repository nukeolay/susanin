import 'dart:collection';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';

//объявил интерфейс
abstract class SusaninRepository {
  Future<SusaninData> getSusaninData();

  Future<String> setSusaninData({SusaninData susaninData});
}
