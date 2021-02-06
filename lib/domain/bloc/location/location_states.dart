import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';

abstract class LocationState {}

class LocationStateStart extends LocationState {}

class LocationStateEmptyLocationList extends LocationState {}

class LocationStateLocationListLoaded extends LocationState {
  SusaninData susaninData;
  String option;
  LocationStateLocationListLoaded(this.susaninData, [this.option]);
}

class LocationStateDataLoading extends LocationState {}

class LocationStateDataLoaded extends LocationState {
  // SusaninData _susaninData;
  //
  // AppStateDataLoaded({SusaninData susaninData}) {
  //   _susaninData = susaninData;
  // }
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

class LocationStateFirstTimeStarted extends LocationState {}

class LocationStatePressedShareLocation extends LocationState {}

class LocationStatePressedRenameLocation extends LocationState {}

class LocationStateLocationRenamed extends LocationState {}

class LocationStateGpsDisabled extends LocationState {}

class LocationStateGpsEnabled extends LocationState {}

class LocationStateLowAccuracy extends LocationState {}

class DataStateDataLoading extends LocationState {}

class DataStateEmptyLocationList extends LocationState {}

class DataStateThemeToggled extends LocationState {}

