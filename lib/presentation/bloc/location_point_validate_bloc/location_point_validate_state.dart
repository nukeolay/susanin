import 'package:equatable/equatable.dart';

class LocationPointValidateState extends Equatable {
  final bool isNameValid;
  final bool isLatutideValid;
  final bool isLongitudeValid;

  const LocationPointValidateState({
    required this.isNameValid,
    required this.isLatutideValid,
    required this.isLongitudeValid,
  });

  @override
  List<Object?> get props => [
        isNameValid,
        isLatutideValid,
        isLongitudeValid,
      ];

  LocationPointValidateState copyWith({
    bool? isNameValid,
    bool? isLatutideValid,
    bool? isLongitudeValid,
  }) {
    return LocationPointValidateState(
      isNameValid: isNameValid ?? this.isNameValid,
      isLatutideValid: isLatutideValid ?? this.isLatutideValid,
      isLongitudeValid: isLongitudeValid ?? this.isLongitudeValid,
    );
  }
}
