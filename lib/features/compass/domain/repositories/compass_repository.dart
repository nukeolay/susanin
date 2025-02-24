import 'package:rxdart/rxdart.dart';

import '../entities/compass.dart';

abstract class CompassRepository {
  ValueStream<CompassEntity> get compassStream;
  Future<void> close();
}
