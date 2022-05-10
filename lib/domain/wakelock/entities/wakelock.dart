import 'package:equatable/equatable.dart';

class WakelockEntity extends Equatable {
  final bool isEnabled;
  const WakelockEntity({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [isEnabled];
}
