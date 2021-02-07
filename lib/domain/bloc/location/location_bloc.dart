import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/theme/config.dart';

import 'location_events.dart';
import 'location_states.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  SusaninData susaninDataLocal; //тут будем хранить локальную копию и получать ее только при загрузке программы

  LocationBloc(this.susaninRepository) : super(LocationStateDataLoading()); //todo установить init state

  @override
  Stream<LocationState> mapEventToState(LocationEvent locationEvent) async* {
    if (locationEvent is LocationEventGetData) {
      try {
        susaninDataLocal = await susaninRepository.getSusaninData(); //получили синглтон репозитория
        currentTheme.setThemeMode(susaninDataLocal.getIsDarkTheme);
        if (susaninDataLocal.getLocationList.length == 0) {
          yield LocationStateEmptyLocationList(
              susaninDataLocal); // если список локаций пустой, то состояние AppStateEmptyLocationList и написать инструкцию вместо виджета со списком
        } else {
          yield LocationStateLocationListLoaded(
              susaninDataLocal); // если список локаций не пустой, то состояние AppStateLocationListLoaded и вывести список локаций
        }
      } catch (e) {
        yield LocationStateFirstTimeStarted(susaninDataLocal);
      }
    }
    else if (locationEvent is LocationEventPressedToggleTheme) {
      // если нажали кнопку переключить тему, то сначала изменится значение переменной, потом эти данные запишутся в память телефона, и только потом перейдем в состояние того, что тема переключилась
      currentTheme.toggleTheme(); // переключили тему
      susaninDataLocal.setIsDarkTheme(!susaninDataLocal.getIsDarkTheme); // переключили тему
      susaninRepository.setSusaninData(susaninData: susaninDataLocal);
      if (susaninDataLocal.getLocationList.length == 0) {
        yield LocationStateEmptyLocationList(
            susaninDataLocal); // если список локаций пустой, то состояние AppStateEmptyLocationList и написать инструкцию вместо виджета со списком
      } else {
        yield LocationStateLocationListLoaded(
            susaninDataLocal); // если список локаций не пустой, то состояние AppStateLocationListLoaded и вывести список локаций
      }
    } else if (locationEvent is LocationEventPressedAddNewLocation) {
      susaninDataLocal.getLocationList
          .addFirst(new LocationPoint.createNew(latitude: 111, longitude: 222, pointName: "Name ${susaninDataLocal.getLocationCounter + 1}"));
      susaninDataLocal.increnemtLocationCounter();
      susaninDataLocal.setSelectedLocationPointId(0);
      susaninRepository.setSusaninData(
          susaninData:
              susaninDataLocal); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData todo это не проверено
      yield LocationStateLocationListLoaded(susaninDataLocal);
    } else if (locationEvent is LocationEventPressedSelectLocation) {
      susaninDataLocal.setSelectedLocationPointId(locationEvent.index);
      susaninRepository.setSusaninData(
          susaninData:
              susaninDataLocal); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData todo это не проверено
      yield LocationStateLocationListLoaded(susaninDataLocal);
    } else if (locationEvent is LocationEventPressedDeleteLocation) {
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
        yield LocationStateEmptyLocationList(susaninDataLocal);
      } else {
        yield LocationStateLocationListLoaded(susaninDataLocal, "delete");
      }
      Future.delayed(Duration(milliseconds: 3001), () {
        susaninRepository.setSusaninData(susaninData: susaninDataLocal);
      });
    } else if (locationEvent is LocationEventPressedUndoDeletion) {
      SusaninData oldSusaninData = await susaninRepository.getSusaninData();
      susaninRepository.setSusaninData(susaninData: oldSusaninData);
      susaninDataLocal = oldSusaninData;
      yield LocationStateLocationListLoaded(susaninDataLocal);
    } else if (locationEvent is LocationEventPressedRenameLocation) {
      int index = locationEvent.index;
      String pointName = locationEvent.newName;
      susaninDataLocal.getLocationList.elementAt(index).setPointName(pointName);
      susaninRepository.setSusaninData(susaninData: susaninDataLocal);
      yield LocationStateLocationListLoaded(susaninDataLocal);
    }
  }
}
