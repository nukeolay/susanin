import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/mixins/pointer_calculations.dart';
import '../../../../../../features/compass/domain/entities/compass.dart';
import '../../../../../../features/compass/domain/repositories/compass_repository.dart';
import '../../../../../../features/location/domain/entities/position.dart';
import '../../../../../../features/location/domain/repositories/location_repository.dart';

part 'demo_pointer_state.dart';

class DemoPointerCubit extends Cubit<DemoPointerState> {
  DemoPointerCubit({
    required LocationRepository locationRepository,
    required CompassRepository compassRepository,
  })  : _locationRepository = locationRepository,
        _compassRepository = compassRepository,
        super(DemoPointerState.initial);

  final LocationRepository _locationRepository;
  final CompassRepository _compassRepository;

  StreamSubscription<PositionEntity>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void init() {
    _positionSubscription ??=
        _locationRepository.positionStream.listen(_positionEventHandler);
    _compassSubscription ??=
        _compassRepository.compassStream.listen(_compassEventHandler);
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    return super.close();
  }

  void _compassEventHandler(CompassEntity entity) {
    emit(
      state.copyWith(
        hasCompass: entity.status.isSuccess,
        compassNorth: entity.north,
      ),
    );
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(
      state.copyWith(
        locationServiceStatus: entity.status,
        userLatitude: entity.latitude,
        userLongitude: entity.longitude,
        accuracy: entity.accuracy,
      ),
    );
  }
}
