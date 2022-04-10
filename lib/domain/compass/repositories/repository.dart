import 'package:susanin/domain/compass/entities/compass.dart';

abstract class CompassRepository {
  Stream<CompassEntity> get compassStream;
}
