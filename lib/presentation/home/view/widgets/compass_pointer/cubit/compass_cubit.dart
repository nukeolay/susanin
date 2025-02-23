import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';

part 'compass_state.dart';

class CompassCubit extends Cubit<CompassState> {
  CompassCubit({
    required CompassRepository compassRepository,
  })  : _compassRepository = compassRepository,
        super(CompassState.initial);

  final CompassRepository _compassRepository;
  StreamSubscription<CompassEntity>? _compassSubscription;

  void init() {
    _compassSubscription ??= _compassRepository.compassStream.listen(
      _compassHandler,
    );
  }

  void _compassHandler(CompassEntity entity) {
    final compassStatus = entity.status;
    final compassNorth = entity.north;
    final compassAccuracy = entity.accuracy;
    final angle =
        compassNorth != null ? compassNorth * (math.pi / 180) * -1 : null;
    final accuracy =
        compassAccuracy != null ? compassAccuracy * (math.pi / 180) : null;
    emit(
      state.copyWith(
        status: compassStatus,
        angle: angle,
        accuracy: accuracy,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _compassSubscription?.cancel();
    super.close();
  }
}
