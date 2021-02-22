import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:geolocator/geolocator.dart';

import 'location_events.dart';
import 'location_states.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  SusaninData susaninDataLocal; //тут будем хранить локальную копию и получать ее только при загрузке программы

  LocationBloc(this.susaninRepository) : super(LocationStateDataLoading());

  @override
  Stream<LocationState> mapEventToState(LocationEvent locationEvent) async* {
    if (locationEvent is LocationEventGetData) {
      try {
        susaninDataLocal = await susaninRepository.getSusaninData(); //получили синглтон репозитория
        //currentTheme.setThemeMode(susaninDataLocal.getIsDarkTheme);
        if (susaninDataLocal.getLocationList.length == 0) {
          yield LocationStateErrorEmptyLocationList(
              susaninDataLocal); // если список локаций пустой, то состояние AppStateEmptyLocationList и написать инструкцию вместо виджета со списком
        } else {
          yield LocationStateLocationListLoaded(
              susaninDataLocal); // если список локаций не пустой, то состояние AppStateLocationListLoaded и вывести список локаций
        }
      } catch (e) {
        yield LocationStateFirstTimeStarted(susaninDataLocal);
      }
    }
    if (locationEvent is LocationEventPressedAddNewLocation) {
      susaninDataLocal = await susaninRepository.getSusaninData(); //получили синглтон репозитория
      yield LocationStateLocationListLoaded(susaninDataLocal);
    }
    if (locationEvent is LocationEventPressedSelectLocation) {
      susaninDataLocal.setSelectedLocationPointId(locationEvent.index);
      await susaninRepository.setSusaninData(
          susaninData:
              susaninDataLocal); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData todo это не проверено
      yield LocationStateLocationListLoaded(susaninDataLocal);
    }
    if (locationEvent is LocationEventPressedDeleteLocation) {
      if (locationEvent.index == susaninDataLocal.getSelectedLocationPointId) {
        if (locationEvent.index == 0) {
          susaninDataLocal.setSelectedLocationPointId(0);
        } else {
          susaninDataLocal.setSelectedLocationPointId(locationEvent.index - 1);
        }
      } else if (susaninDataLocal.getSelectedLocationPointId > locationEvent.index) {
        susaninDataLocal.setSelectedLocationPointId(susaninDataLocal.getSelectedLocationPointId - 1);
      } else if (susaninDataLocal.getSelectedLocationPointId < locationEvent.index) {}
      susaninDataLocal.deleteLocationPoint(locationEvent.index);
      if (susaninDataLocal.getLocationList.length == 0) {
        await susaninRepository.setSusaninData(susaninData: susaninDataLocal);
        yield LocationStateErrorEmptyLocationList(susaninDataLocal);
      } else {
        await susaninRepository.setSusaninData(susaninData: susaninDataLocal);
        yield LocationStateLocationListLoaded(susaninDataLocal);
      }
    } if (locationEvent is LocationEventPressedRenameLocation) {
      int index = locationEvent.index;
      String pointName = locationEvent.newName;
      susaninDataLocal.getLocationList.elementAt(index).setPointName(pointName);
      await susaninRepository.setSusaninData(susaninData: susaninDataLocal);
      yield LocationStateLocationListLoaded(susaninDataLocal);
    }
  }
}
