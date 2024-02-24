import 'package:equatable/equatable.dart';

class CompassEntity extends Equatable {
  const CompassEntity({
    required this.north,
    required this.accuracy,
  });

  final double north;
  final double accuracy;

  @override
  List<Object?> get props => [north, accuracy];
}
