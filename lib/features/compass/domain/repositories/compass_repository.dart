import 'package:rxdart/rxdart.dart';

import 'package:susanin/features/compass/domain/entities/compass.dart';

abstract class CompassRepository {
  ValueStream<CompassEntity> get compassStream;
  Future<void> close();
}
