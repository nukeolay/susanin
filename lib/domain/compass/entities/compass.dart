import 'package:equatable/equatable.dart';

class CompassEntity extends Equatable {
  final double north;
  final double accuracy;
  const CompassEntity({
    required this.north,
    required this.accuracy,
  });

  @override
  List<Object?> get props => [north, accuracy];
}
