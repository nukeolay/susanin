import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  const PositionEntity({
    required this.longitude,
    required this.latitude,
    required this.accuracy,
  });

  final double longitude;
  final double latitude;
  final double accuracy;

  @override
  List<Object?> get props => [
        longitude,
        latitude,
        accuracy,
      ];
}
