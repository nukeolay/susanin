import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  final double longitude;
  final double latitude;
  final double accuracy;

  const PositionEntity({
    required this.longitude,
    required this.latitude,
    required this.accuracy,
  });

  @override
  List<Object?> get props => [
        longitude,
        latitude,
        accuracy,
      ];
}
