import 'package:rxdart/rxdart.dart';

import 'package:susanin/features/location/domain/entities/position.dart';

abstract class LocationRepository {
  ValueStream<PositionEntity> get positionStream;
  Future<bool> checkPermission();
  Future<LocationStatus> requestPermission();
  Future<void> close();
}
