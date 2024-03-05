import 'package:equatable/equatable.dart';

class CompassEntity extends Equatable {
  const CompassEntity({
    required this.north,
    required this.accuracy,
    required this.status,
  });

  const CompassEntity.value({
    required this.north,
    required this.accuracy,
  }) : status = CompassStatus.success;

  const CompassEntity.loading()
      : accuracy = null,
        north = null,
        status = CompassStatus.loading;

  const CompassEntity.failure()
      : accuracy = null,
        north = null,
        status = CompassStatus.failure;

  final double? north;
  final double? accuracy;
  final CompassStatus status;

  @override
  List<Object?> get props => [north, accuracy, status];
}

enum CompassStatus {
  loading,
  failure,
  success;

  bool get isLoading => this == CompassStatus.loading;
  bool get isFailure => this == CompassStatus.failure;
  bool get isSuccess => this == CompassStatus.success;
}
