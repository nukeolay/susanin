import 'package:equatable/equatable.dart';

import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';

class GetCompassStream extends UseCase<Stream<CompassEvent>, NoParams> {
  const GetCompassStream(this._compassRepository);

  final CompassRepository _compassRepository;

  @override
  Stream<CompassEvent> call(NoParams params) async* {
    final lastValue = _compassRepository.compassStream.valueOrNull;
    if (lastValue == null) {
      yield CompassEvent.loading;
    } else {
      final lastState = CompassEvent(
        entity: lastValue,
        status: CompassStatus.success,
      );
      yield lastState;
    }
    try {
      final stream = _compassRepository.compassStream;
      await for (var event in stream) {
        final state = CompassEvent(
          entity: event,
          status: CompassStatus.success,
        );
        yield state;
      }
    } catch (error) {
      yield CompassEvent.failure;
    }
  }
}

class CompassEvent extends Equatable {
  const CompassEvent({required this.entity, required this.status});

  final CompassEntity? entity;
  final CompassStatus status;

  static const loading = CompassEvent(
    entity: null,
    status: CompassStatus.loading,
  );

  static const failure = CompassEvent(
    entity: null,
    status: CompassStatus.failure,
  );

  bool get isLoading => status.isLoading;
  bool get isSuccess => status.isSuccess;
  bool get isFailure => status.isFailure;

  @override
  List<Object?> get props => [entity, status];
}

enum CompassStatus { loading, failure, success }

extension CompassStatusExtension on CompassStatus {
  bool get isLoading => this == CompassStatus.loading;
  bool get isFailure => this == CompassStatus.failure;
  bool get isSuccess => this == CompassStatus.success;
}
