import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';

abstract class LocationState {

}

class LocationStateDataLoading extends LocationState {}

class LocationStateDataLoaded extends LocationState {
  SusaninData susaninData;

  LocationStateDataLoaded(this.susaninData);

}

class LocationStateError extends LocationStateDataLoaded {
  LocationStateError(SusaninData susaninData) : super(susaninData);
}

class LocationStateErrorEmptyLocationList extends LocationStateError {
  LocationStateErrorEmptyLocationList(SusaninData susaninData) : super(susaninData);
}

class LocationStateLocationListLoaded extends LocationStateDataLoaded {
  SusaninData susaninData;
  String option;

  LocationStateLocationListLoaded(this.susaninData, [this.option]) : super(susaninData);
}

class LocationStateLocationAddingLocation extends LocationStateLocationListLoaded {
  SusaninData susaninData;

  LocationStateLocationAddingLocation(this.susaninData) : super(susaninData);
}

class LocationStatePressedSetLocation extends LocationState {}

class LocationStateLocationSetted extends LocationState {}

class LocationStatePressedDeleteLocation extends LocationState {}

class LocationStateLocationDeleted extends LocationState {}

class LocationStatePressedNewLocation extends LocationState {}

class LocationStateNewLocationAdded extends LocationState {
  SusaninData susaninData;

  LocationStateNewLocationAdded(this.susaninData);
}

class LocationStateFirstTimeStarted extends LocationStateDataLoaded {
  LocationStateFirstTimeStarted(SusaninData susaninData) : super(susaninData);
}

class LocationStatePressedShareLocation extends LocationState {}

class LocationStatePressedRenameLocation extends LocationState {}