import 'package:equatable/equatable.dart';

class CompassEntity extends Equatable {
  final double north;
  const CompassEntity(this.north);

  @override
  List<Object?> get props => [north];
}
