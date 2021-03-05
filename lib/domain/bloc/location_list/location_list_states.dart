import 'package:flutter/material.dart';
import 'package:susanin/domain/model/susanin_data.dart';

abstract class LocationListState {}

class LocationListStateInit extends LocationListState {}

class LocationListStateDataLoading extends LocationListState {}

class LocationListStateDataLoaded extends LocationListState {
  SusaninData susaninData;

  LocationListStateDataLoaded({@required this.susaninData});
}

class LocationListStateError extends LocationListState {}

class LocationListStateErrorEmptyLocationList extends LocationListStateError {}

class LocationListStateErrorPermissionDeniedForever extends LocationListStateError {}

class LocationListStateErrorPermissionDenied extends LocationListStateError {}

class LocationListStateErrorServiceDisabled extends LocationListStateError {}

class LocationListStateErrorNoCompass extends LocationListStateError {}

class LocationListStateErrorReadingData extends LocationListStateError {}
