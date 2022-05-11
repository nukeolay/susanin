import 'dart:async';
import 'dart:math' as math;

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_state.dart';

class CompassCubit extends Cubit<CompassState> {
  final GetCompassStream _getCompassStream;
  late final StreamSubscription<Either<Failure, CompassEntity>>
      _compassSubscription;

  CompassCubit({
    required GetCompassStream getCompassStream,
  })  : _getCompassStream = getCompassStream,
        super(const CompassState(
          status: CompassStatus.loading,
          angle: 0,
          accuracy: 0,
        )) {
    _init();
  }

  void _init() {
    _compassSubscription = _getCompassStream().listen(_compassHandler);
  }

  void _compassHandler(Either<Failure, CompassEntity> event) {
    event.fold(
      (failure) => emit(state.copyWith(status: CompassStatus.failure)),
      (compass) => emit(
        state.copyWith(
          status: CompassStatus.loaded,
          angle: (compass.north * (math.pi / 180) * -1),
          accuracy: (compass.accuracy * (math.pi / 180)),
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    _compassSubscription.cancel();
    super.close();
  }
}
