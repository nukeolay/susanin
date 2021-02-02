import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';

abstract class DataState {}

class DataStateStart extends DataState {
  // SusaninRepository susaninRepository;
  // DataStateStart(this.susaninRepository);
  //   try {
  //     SusaninData _susaninData = await susaninRepository.getSusaninData();
  //     yield DataStateDataLoaded(susaninData: _susaninData);
  //   } catch (e) {
  //     yield DataStateEmptyLocationList();
  //   }
}

class DataStateEmptyLocationList extends DataState {}

class DataStateLocationListLoaded extends DataState {
  SusaninData susaninData;
  DataStateLocationListLoaded(this.susaninData);
}

class DataStateDataLoading extends DataState {}

class DataStateDataLoaded extends DataState {
  // SusaninData _susaninData;
  //
  // DataStateDataLoaded({SusaninData susaninData}) {
  //   _susaninData = susaninData;
  // }
}

class DataStateToggleThemePressed extends DataState {}

class DataStateThemeToggled extends DataState {}

class DataStateSetLocationPressed extends DataState {}

class DataStateLocationSetted extends DataState {}

class DataStateDeleteLocationPressed extends DataState {}

class DataStateLocationDeleted extends DataState {}

class DataStateNewLocationPressed extends DataState {}

class DataStateNewLocationAdded extends DataState {}

class DataSateShareLocationPressed extends DataState {}

class DataStateRenameLocationPressed extends DataState {}

class DataStateLocationRenamed extends DataState {}

class DataStateGpsDisabled extends DataState {}

class DataStateGpsEnabled extends DataState {}

class DataStateLowAccuracy extends DataState {}

class DataStateFirstTimeStarted extends DataState {}
