part of 'compass_cubit.dart';

class CompassState extends Equatable {
  const CompassState({
    required this.angle,
    required this.accuracy,
    required this.status,
  });

  final double angle;
  final double accuracy;
  final CompassStatus status;

  static const CompassState initial = CompassState(
    status: CompassStatus.loading,
    angle: 0,
    accuracy: 0,
  );

  bool get needCalibration => accuracy > 0.262; // 15 degrees

  CompassState copyWith({
    double? angle,
    double? accuracy,
    bool? needCalibration,
    CompassStatus? status,
  }) {
    return CompassState(
      angle: angle ?? this.angle,
      accuracy: accuracy ?? this.accuracy,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        angle,
        accuracy,
        status,
      ];
}
