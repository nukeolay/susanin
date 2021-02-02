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
  bool firstTime = true;

  LocationBloc(this.susaninRepository) : super(LocationStateDataLoading());//todo установить init state

  @override
  Stream<LocationState> mapEventToState(LocationEvent locationEvent) async* {
    if (locationEvent is LocationEventPressedAddNewLocation) {
      print("add new location"); //todo удалить
      SusaninData _susaninData = await susaninRepository.getSusaninData(); //получили синглтон репозитория
      _susaninData.getLocationList.addFirst(new LocationPoint.createNew(latitude: 111, longitude: 222, pointName: "Name"));
      _susaninData.increnemtLocationCounter();
      _susaninData.setSelectedLocationPointId(0);
      susaninRepository.setSusaninData(
          susaninData:
              _susaninData); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData todo это не проверено
      yield LocationStateNewLocationAdded(_susaninData);
    }
    // else if (locationEvent is PressEventAddNewLocation) {
    //   print("add new location"); //todo удалить
    //   SusaninData _susaninData = await susaninRepository.getSusaninData(); //получили синглтон репозитория
    //   _susaninData.getLocationList.addFirst(new LocationPoint.createNew(latitude: 111, longitude: 222, pointName: "Name"));
    //   _susaninData.increnemtLocationCounter();
    //   _susaninData.setSelectedLocationPointId(0);
    //   susaninRepository.setSusaninData(
    //       susaninData:
    //           _susaninData); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData todo это не проверено
    //   yield AppStateNewLocationAdded();
    // }
  }
}
