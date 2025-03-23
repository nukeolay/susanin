import 'package:rxdart/rxdart.dart';

import '../entities/position.dart';

abstract class LocationRepository {
  ValueStream<PositionEntity> get positionStream;
  Future<bool> checkPermission();
  Future<LocationStatus> requestPermission();
  Future<void> close();
}
