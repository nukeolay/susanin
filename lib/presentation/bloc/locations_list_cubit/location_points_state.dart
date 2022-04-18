import 'package:equatable/equatable.dart';

abstract class LocationPointsState extends Equatable {
  const LocationPointsState();

  @override
  List<Object> get props => [];
}

class NoLocationPoints extends LocationPointsState {
  @override
  List<Object> get props => [];
}

class LocationPointsLoading extends LocationPointsState {
  @override
  List<Object> get props => [];
}
