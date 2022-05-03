import 'package:equatable/equatable.dart';

enum CompassStatus {
  loading,
  loaded,
  failure,
}

class CompassState extends Equatable {
  final double angle;
  final double accuracy;
  final CompassStatus status;

  const CompassState({
    required this.angle,
    required this.accuracy,
    required this.status,
  });

  @override
  List<Object> get props => [
        angle,
        accuracy,
        status,
      ];

  CompassState copyWith({
    double? angle,
    double? accuracy,
    CompassStatus? status,
  }) {
    return CompassState(
      angle: angle ?? this.angle,
      accuracy: accuracy ?? this.accuracy,
      status: status ?? this.status,
    );
  }
}
