import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'fab_events.dart';
import 'fab_states.dart';

class FabBloc extends Bloc<FabEvent, FabState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  SusaninData susaninData; //тут будем хранить локальную копию и получать ее только при загрузке программы


  FabBloc(this.susaninRepository) : super(FabStateInit());

  @override
  Stream<FabState> mapEventToState(FabEvent fabEvent) async* {
    if (fabEvent is FabEventPressed) {
      yield FabStateLoading();
      susaninData = await susaninRepository.getSusaninData();
      susaninData.getLocationList.addFirst(new LocationPoint.createNew(
          latitude: fabEvent.currentPosition.latitude, longitude: fabEvent.currentPosition.longitude, pointName: "Name ${susaninData.getLocationCounter + 1}"));
      susaninData.increnemtLocationCounter();
      susaninData.setSelectedLocationPointId(0);
      print("in fabBloc susaninData BEFORE save: $susaninData");
      await susaninRepository.setSusaninData(
          susaninData:
          susaninData);
      susaninData = await susaninRepository.getSusaninData();
      print("in fabBloc susaninData AFTER save: $susaninData");
      yield FabStateAdded();
    }
    if (fabEvent is FabEventLoaded) {
      yield FabStateNormal();
    }
    if (fabEvent is FabEventError) {
      yield FabStateError();
    }
  }
}
