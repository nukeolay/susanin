import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';

part 'compass_state.dart';

class CompassCubit extends Cubit<CompassState> {
  CompassCubit({
    required GetCompassStream getCompassStream,
  })  : _getCompassStream = getCompassStream,
        super(CompassState.initial) {
    _init();
  }

  final GetCompassStream _getCompassStream;
  late final StreamSubscription<CompassEvent> _compassSubscription;

  void _init() {
    _compassSubscription = _getCompassStream(const NoParams()).listen(
      _compassHandler,
    );
  }

  void _compassHandler(CompassEvent event) {
    final compass = event.entity;
    final status = event.status;
    final angle = compass != null ? compass.north * (math.pi / 180) * -1 : null;
    final accuracy =
        compass != null ? compass.accuracy * (math.pi / 180) : null;
    emit(state.copyWith(status: status, angle: angle, accuracy: accuracy));
  }

  @override
  Future<void> close() async {
    await _compassSubscription.cancel();
    super.close();
  }
}
