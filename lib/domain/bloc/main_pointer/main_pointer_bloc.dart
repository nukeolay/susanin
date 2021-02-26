import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';

import 'main_pointer_events.dart';
import 'main_pointer_states.dart';

class MainPointerBloc extends Bloc<MainPointerEvent, MainPointerState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  SusaninData susaninData; //тут будем хранить локальную копию и получать ее только при загрузке программы

  Stream<CompassEvent> _compassStream;
  StreamSubscription<CompassEvent> _compassSubscription;

  Stream<Position> _positionStream;
  StreamSubscription<Position> _positionSubscription;

  LocationPermission permission;
  bool serviceEnabled;

  Position tempCurrentPosition;
  double tempCurrentHeading;
  LocationPoint tempSelectedLocationPoint;

  MainPointerBloc(this.susaninRepository, this._compassStream, this._positionStream) : super(MainPointerStateLoading());

  @override
  Stream<MainPointerState> mapEventToState(MainPointerEvent mainPointerEvent) async* {
    // if (mainPointerEvent is MainPointerEventCheckPermissionsOnOff) {
    //   //проверка разрешений
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.deniedForever) {
    //     //если разрешение заблокировано
    //     add(MainPointerEventErrorPermissionDeniedForever());
    //   } else if (permission == LocationPermission.denied) {
    //     //если разрешение не выдано один раз
    //     add(MainPointerEventErrorPermissionDenied());
    //   } else {
    //     //если с разрешением все норм, то проверяем включен ли сервис геолокации
    //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //     if (!serviceEnabled) {
    //       add(MainPointerEventErrorServiceDisabled());
    //     } else {
    //       add(MainPointerEventGetServices());
    //     }
    //   }
    // }

    if (mainPointerEvent is MainPointerEventGetServices) {
      SusaninData susaninData = await susaninRepository.getSusaninData();
      try {
        tempSelectedLocationPoint = susaninData.getSelectedLocationPoint; //если локаций не было, то чтобы не вывлетело исключение, при чтении
      } catch (e) {
        tempSelectedLocationPoint = null;
      }

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        add(MainPointerEventErrorServiceDisabled());
      }
      //работаем с потоком компасса
      _compassSubscription?.cancel(); //отменяем подписку на поток компасса, если по какой-то причине опять запщен ивент MainPointerEventGetServices
      _compassSubscription = _compassStream.listen((CompassEvent compassEvent) async {
        //подписываемся на поток компасса

        tempCurrentHeading = compassEvent.heading;
        if (_positionSubscription.isPaused) {
          _positionSubscription.resume();
        }
        //serviceEnabled = true; todo закомментировал

        add(MainPointerEventChanged(
            heading: compassEvent.heading,
            currentPosition: tempCurrentPosition,
            selectedLocationPoint: tempSelectedLocationPoint)); //добавляем событие с углом пворота компасса
      }, onError: (compassError) async {
        _positionSubscription?.pause();
        add(MainPointerEventErrorNoCompass());
      }); //если ошибка в потоке компасса, то авляем событие с ошибкой компасса

      //работаем с потоком геолокации
      _positionSubscription
          ?.cancel(); //отменяем подписку на поток геолокации, если по какой-то причине опять запщен ивент MainPointerEventGetServices
      _positionSubscription = _positionStream.listen((Position position) async {
        tempCurrentPosition = position;
        //serviceEnabled = await Geolocator.isLocationServiceEnabled(); todo закомментировал
        if (_compassSubscription.isPaused) {
          _compassSubscription.resume();
        }
        add(MainPointerEventChanged(
            heading: tempCurrentHeading,
            currentPosition: position,
            selectedLocationPoint: tempSelectedLocationPoint)); //добавляем событие с текущей геолокацией
      }, onError: (locationError) async {
        _compassSubscription?.pause();
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          add(MainPointerEventErrorServiceDisabled());
        }
      });
    }

    if (mainPointerEvent is MainPointerEventChanged) {
      //какие-то данные пришли из потока компасса и геолокации
      serviceEnabled = true;
      if (mainPointerEvent.currentPosition != null && mainPointerEvent.heading != null && mainPointerEvent.selectedLocationPoint != null) {
        yield MainPointerStateLoaded(
            heading: mainPointerEvent.heading, currentPosition: mainPointerEvent.currentPosition, selectedLocationPoint: tempSelectedLocationPoint);
      }
    }

    if (mainPointerEvent is MainPointerEventErrorNoCompass) {
      yield MainPointerStateErrorNoCompass();
    }

    if (mainPointerEvent is MainPointerEventErrorPermissionDenied) {
      yield MainPointerStateErrorPermissionDenied();
    }

    if (mainPointerEvent is MainPointerEventErrorPermissionDeniedForever) {
      yield MainPointerStateErrorPermissionDenied();
    }

    if (mainPointerEvent is MainPointerEventErrorServiceDisabled) {
      yield MainPointerStateErrorServiceDisabled();
    }

    if (mainPointerEvent is MainPointerEventEmptyList) {
      tempCurrentPosition = null;
      tempCurrentHeading = null;
      tempSelectedLocationPoint = null;
      _compassSubscription?.cancel();
      _positionSubscription?.cancel();
      yield MainPointerStateEmptyList();
    }

    if (mainPointerEvent is MainPointerEventSelectPoint) {
      tempSelectedLocationPoint = mainPointerEvent.selectedLocationPoint;
      if (!serviceEnabled) {
        yield MainPointerStateErrorServiceDisabled();
      } else if (tempCurrentPosition != null && tempCurrentHeading != null && tempSelectedLocationPoint != null) {
        yield MainPointerStateLoaded(
            heading: tempCurrentHeading, currentPosition: tempCurrentPosition, selectedLocationPoint: mainPointerEvent.selectedLocationPoint);
      } else {
        yield MainPointerStateLoading();
      }
    }
  }
}
