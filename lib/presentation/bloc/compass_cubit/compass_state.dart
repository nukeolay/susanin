import 'package:equatable/equatable.dart';

enum CompassStatus {
  loading,
  loaded,
  failure,
}

class CompassState extends Equatable {
  final double angle;
  final double accuracy;
  final bool needCalibration;
  final CompassStatus status;

  const CompassState({
    required this.angle,
    required this.accuracy,
    required this.needCalibration,
    required this.status,
  });

  @override
  List<Object> get props => [
        angle,
        accuracy,
        status,
        needCalibration,
      ];

  CompassState copyWith({
    double? angle,
    double? accuracy,
    bool? needCalibration,
    CompassStatus? status,
  }) {
    return CompassState(
      angle: angle ?? this.angle,
      accuracy: accuracy ?? this.accuracy,
      needCalibration: needCalibration ?? this.needCalibration,
      status: status ?? this.status,
    );
  }
}
