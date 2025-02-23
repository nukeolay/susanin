part of 'validator_bloc.dart';

class LocationValidatorState extends Equatable {
  const LocationValidatorState({
    required this.isNameValid,
    required this.isLatutideValid,
    required this.isLongitudeValid,
  });

  const LocationValidatorState.initial()
      : isNameValid = true,
        isLatutideValid = true,
        isLongitudeValid = true;

  final bool isNameValid;
  final bool isLatutideValid;
  final bool isLongitudeValid;

  bool get isValid => isNameValid && isLatutideValid && isLongitudeValid;

  LocationValidatorState copyWith({
    bool? isNameValid,
    bool? isLatutideValid,
    bool? isLongitudeValid,
  }) {
    return LocationValidatorState(
      isNameValid: isNameValid ?? this.isNameValid,
      isLatutideValid: isLatutideValid ?? this.isLatutideValid,
      isLongitudeValid: isLongitudeValid ?? this.isLongitudeValid,
    );
  }

  @override
  List<Object?> get props => [
        isNameValid,
        isLatutideValid,
        isLongitudeValid,
      ];
}
