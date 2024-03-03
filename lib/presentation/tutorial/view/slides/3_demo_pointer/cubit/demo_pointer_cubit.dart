import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/settings/domain/use_cases/get_settings.dart';
import 'package:susanin/core/mixins/pointer_calculations.dart';

part 'demo_pointer_state.dart';

class DemoPointerCubit extends Cubit<DemoPointerState> {
  DemoPointerCubit({
    required GetSettings getSettings,
    required GetPositionStream getPositionStream,
    required CompassRepository compassRepository,
  })  : _getSettings = getSettings,
        _getPositionStream = getPositionStream,
        _compassRepository = compassRepository,
        super(DemoPointerState.initial) {
    _init();
  }

  final GetSettings _getSettings;
  final GetPositionStream _getPositionStream;
  final CompassRepository _compassRepository;

  StreamSubscription<PositionEvent>? _positionSubscription;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void _init() {
    final settings = _getSettings(const NoParams());
    emit(state.copyWith(isFirstTime: settings.isFirstTime));
    _positionSubscription =
        _getPositionStream(const NoParams()).listen(_positionEventHandler);
    _compassSubscription =
        _compassRepository.compassStream.listen(_compassEventHandler);
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _compassSubscription?.cancel();
    return super.close();
  }

  void _compassEventHandler(CompassEntity entity) {
    emit(state.copyWith(
      hasCompass: entity.status.isSuccess ? true : false,
      compassNorth: entity.north,
    ));
  }

  void _positionEventHandler(PositionEvent event) {
    final position = event.entity;
    final status = event.status;
    emit(state.copyWith(
      locationServiceStatus: status,
      userLatitude: position?.latitude,
      userLongitude: position?.longitude,
      accuracy: position?.accuracy,
    ));
  }
}
