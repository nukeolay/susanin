import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  const PositionEntity({
    required this.status,
    required this.longitude,
    required this.latitude,
    required this.accuracy,
  });

  final LocationStatus status;
  final double? longitude;
  final double? latitude;
  final double? accuracy;

  const PositionEntity.value({
    required this.longitude,
    required this.latitude,
    required this.accuracy,
  }) : status = LocationStatus.granted;

  const PositionEntity.loading()
      : longitude = null,
        latitude = null,
        accuracy = null,
        status = LocationStatus.loading;

  const PositionEntity.notPermitted()
      : longitude = null,
        latitude = null,
        accuracy = null,
        status = LocationStatus.notPermitted;

  const PositionEntity.disabled()
      : longitude = null,
        latitude = null,
        accuracy = null,
        status = LocationStatus.disabled;

  const PositionEntity.unknownError()
      : longitude = null,
        latitude = null,
        accuracy = null,
        status = LocationStatus.unknownError;

  @override
  List<Object?> get props => [
        longitude,
        latitude,
        accuracy,
      ];
}

enum LocationStatus {
  loading,
  notPermitted,
  disabled,
  granted,
  unknownError;

  bool get isLoading => this == LocationStatus.loading;
  bool get isGranted => this == LocationStatus.granted;
  bool get isNotPermitted => this == LocationStatus.notPermitted;
  bool get isDisabled => this == LocationStatus.disabled;
  bool get isUnknownError => this == LocationStatus.unknownError;
  bool get isFailure => isDisabled || isNotPermitted || isUnknownError;
}
