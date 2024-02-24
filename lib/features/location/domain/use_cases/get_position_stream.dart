import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';

class GetPositionStream extends UseCase<Stream<PositionEvent>, NoParams> {
  const GetPositionStream(this._locationRepository);

  final LocationRepository _locationRepository;

  @override
  Stream<PositionEvent> call(NoParams params) {
    final stream = _locationRepository.positionStream;
    return stream.transform(
      StreamTransformer.fromHandlers(
        handleData: (event, sink) {
          final state = PositionEvent(
            entity: event,
            status: LocationStatus.granted,
          );
          sink.add(state);
        },
        handleError: (error, stackTrace, sink) {
          if (error is LocationServiceDeniedException) {
            sink.add(PositionEvent.notPermitted);
          } else if (error is LocationServiceDisabledException) {
            sink.add(PositionEvent.disabled);
          } else {
            sink.add(PositionEvent.failure);
          }
        },
      ),
    );
  }
}

class PositionEvent extends Equatable {
  const PositionEvent({required this.entity, required this.status});

  final PositionEntity? entity;
  final LocationStatus status;

  static const loading = PositionEvent(
    entity: null,
    status: LocationStatus.loading,
  );

  static const notPermitted = PositionEvent(
    entity: null,
    status: LocationStatus.notPermitted,
  );

  static const disabled = PositionEvent(
    entity: null,
    status: LocationStatus.disabled,
  );

  static const failure = PositionEvent(
    entity: null,
    status: LocationStatus.unknownError,
  );

  // bool get isLoading => status.isLoading;

  @override
  List<Object?> get props => [entity, status];
}

enum LocationStatus { loading, notPermitted, disabled, granted, unknownError }

extension LocationStatusExtension on LocationStatus {
  bool get isLoading => this == LocationStatus.loading;
  bool get isGranted => this == LocationStatus.granted;
  bool get isNotPermitted => this == LocationStatus.notPermitted;
  bool get isDisabled => this == LocationStatus.disabled;
  bool get isUnknownError => this == LocationStatus.unknownError;
  bool get isFailure => isDisabled || isNotPermitted || isUnknownError;
}
