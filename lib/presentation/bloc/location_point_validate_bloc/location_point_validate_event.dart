import 'package:equatable/equatable.dart';

abstract class LocationPointValidateEvent extends Equatable {
  const LocationPointValidateEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends LocationPointValidateEvent {
  const NameChanged({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}

class LatitudeChanged extends LocationPointValidateEvent {
  const LatitudeChanged({required this.latitude});

  final String latitude;

  @override
  List<Object> get props => [latitude];
}

class LongitudeChanged extends LocationPointValidateEvent {
  const LongitudeChanged({required this.longitude});

  final String longitude;

  @override
  List<Object> get props => [longitude];
}

class FlushValidator extends LocationPointValidateEvent {}
