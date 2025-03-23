part of 'validator_bloc.dart';

abstract class LocationValidatorEvent extends Equatable {
  const LocationValidatorEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends LocationValidatorEvent {
  const NameChanged({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}

class LatitudeChanged extends LocationValidatorEvent {
  const LatitudeChanged({required this.latitude});

  final String latitude;

  @override
  List<Object> get props => [latitude];
}

class LongitudeChanged extends LocationValidatorEvent {
  const LongitudeChanged({required this.longitude});

  final String longitude;

  @override
  List<Object> get props => [longitude];
}

class ClearValidator extends LocationValidatorEvent {}
