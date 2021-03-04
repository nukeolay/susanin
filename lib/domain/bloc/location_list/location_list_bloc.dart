import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'location_list_events.dart';
import 'location_list_states.dart';

class LocationListBloc extends Bloc<LocationListEvent, LocationListState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  SusaninData susaninDataLocal; //тут будем хранить локальную копию и получать ее только при загрузке программы

  LocationListBloc(this.susaninRepository) : super(LocationListStateInit());

  @override
  Stream<LocationListState> mapEventToState(LocationListEvent locationListEvent) async* {
    print("locationListEvent: $locationListEvent");
    if (locationListEvent is LocationListEventGetData) {
      try {
        susaninDataLocal = await susaninRepository.getSusaninData(); //получили синглтон репозитория
        if (susaninDataLocal.getLocationList.length == 0) {
          yield LocationListStateErrorEmptyLocationList(); // если список локаций пустой
        } else {
          yield LocationListStateDataLoaded(
              susaninData: susaninDataLocal); // если список локаций не пустой, то состояние AppStateLocationListLoaded и вывести список локаций
        }
      } catch (e) {
        yield LocationListStateErrorReadingData();
      }
    }
    if (locationListEvent is LocationListEventAddNewLocation) {
      susaninDataLocal.getLocationList.addFirst(new LocationPoint.createNew(
          latitude: locationListEvent.currentPosition.latitude,
          longitude: locationListEvent.currentPosition.longitude,
          pointName: "${locationListEvent.defaultName} ${susaninDataLocal.getLocationCounter + 1}"));
      susaninDataLocal.increnemtLocationCounter();
      susaninDataLocal.setSelectedLocationPointId(0);
      await susaninRepository.setSusaninData(susaninData: susaninDataLocal);
      yield LocationListStateDataLoaded(susaninData: susaninDataLocal);
    }
    if (locationListEvent is LocationListEventPressedSelectLocation) {
      susaninDataLocal.setSelectedLocationPointId(locationListEvent.index);
      await susaninRepository.setSusaninData(
          susaninData: susaninDataLocal); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData
      yield LocationListStateDataLoaded(susaninData: susaninDataLocal);
    }
    if (locationListEvent is LocationListEventPressedDeleteLocation) {
      if (locationListEvent.index == susaninDataLocal.getSelectedLocationPointId) {
        if (locationListEvent.index == 0) {
          susaninDataLocal.setSelectedLocationPointId(0);
        } else {
          susaninDataLocal.setSelectedLocationPointId(locationListEvent.index - 1);
        }
      } else if (susaninDataLocal.getSelectedLocationPointId > locationListEvent.index) {
        susaninDataLocal.setSelectedLocationPointId(susaninDataLocal.getSelectedLocationPointId - 1);
      } else if (susaninDataLocal.getSelectedLocationPointId < locationListEvent.index) {}
      susaninDataLocal.deleteLocationPoint(locationListEvent.index);
      if (susaninDataLocal.getLocationList.length == 0) {
        await susaninRepository.setSusaninData(susaninData: susaninDataLocal);
        yield LocationListStateErrorEmptyLocationList();
      } else {
        await susaninRepository.setSusaninData(susaninData: susaninDataLocal);
        yield LocationListStateDataLoaded(susaninData: susaninDataLocal);
      }
    }
    if (locationListEvent is LocationListEventPressedRenameLocation) {
      int index = locationListEvent.index;
      String pointName = locationListEvent.newName;
      susaninDataLocal.getLocationList.elementAt(index).setPointName(pointName);
      await susaninRepository.setSusaninData(susaninData: susaninDataLocal);
      yield LocationListStateDataLoaded(susaninData: susaninDataLocal);
    }
    if (locationListEvent is LocationListEventErrorServiceDisabled) {
      yield LocationListStateErrorServiceDisabled();
    }
    if (locationListEvent is LocationListEventErrorPermissionDenied) {
      yield LocationListStateErrorPermissionDenied();
    }
    if (locationListEvent is LocationListEventErrorPermissionDeniedForever) {
      yield LocationListStateErrorPermissionDeniedForever();
    }
  }
}
