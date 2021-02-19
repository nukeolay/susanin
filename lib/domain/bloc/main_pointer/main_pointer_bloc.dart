import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/model/location_point.dart';

import 'main_pointer_events.dart';
import 'main_pointer_states.dart';

class MainPointerBloc extends Bloc<MainPointerEvent, MainPointerState> {
  Stream<CompassEvent> _compassStream;
  StreamSubscription<CompassEvent> _compassSubscription;

  Stream<Position> _positionStream;
  StreamSubscription<Position> _positionSubscription;

  LocationPermission permission;
  bool serviceEnabled;

  Position tempCurrentPosition;
  double tempCurrentHeading;
  LocationPoint tempSelectedLocationPoint;

  MainPointerBloc(this._compassStream, this._positionStream) : super(MainPointerStateLoading());

  @override
  Stream<MainPointerState> mapEventToState(MainPointerEvent mainPointerEvent) async* {
    if (mainPointerEvent is MainPointerEventCheckPermissionsOnOff) {
      //проверка разрешений
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        //если разрешение заблокировано
        add(MainPointerEventErrorPermissionDeniedForever());
      } else if (permission == LocationPermission.denied) {
        //если разрешение не выдано один раз
        add(MainPointerEventErrorPermissionDenied());
      } else {
        //если с разрешением все норм, то проверяем включен ли сервис геолокации
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          add(MainPointerEventErrorServiceDisabled());
        } else {
          add(MainPointerEventGetServices());
        }
      }
    }

    if (mainPointerEvent is MainPointerEventGetServices) {
      print("here");
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        add(MainPointerEventErrorServiceDisabled());
      }

      //работаем с потоком компасса
      _compassSubscription?.cancel(); //отменяем подписку на поток компасса, если по какой-то причине опять запщен ивент MainPointerEventGetServices
      _compassSubscription = _compassStream.listen((CompassEvent compassEvent) {
        //подписываемся на поток компасса
        tempCurrentHeading = compassEvent.heading;
        if (_positionSubscription.isPaused) {
          _positionSubscription.resume();
        }
        serviceEnabled = true;
        add(MainPointerEventChanged(
            heading: compassEvent.heading,
            currentPosition: tempCurrentPosition,
            selectedLocationPoint: tempSelectedLocationPoint)); //добавляем событие с углом пворота компасса
      }, onError: (compassError) {
        _positionSubscription?.pause();
        add(MainPointerEventErrorNoCompass());
      }); //если ошибка в потоке компасса, то авляем событие с ошибкой компасса

      //работаем с потоком геолокации
      _positionSubscription
          ?.cancel(); //отменяем подписку на поток геолокации, если по какой-то причине опять запщен ивент MainPointerEventGetServices
      _positionSubscription = _positionStream.listen((Position position) async {
        tempCurrentPosition = position;
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
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
      //print("tempCurrentPosition = $tempCurrentPosition && tempCurrentHeading = $tempCurrentHeading && tempSelectedLocationPoint = $tempSelectedLocationPoint");
      if (tempCurrentPosition != null && tempCurrentHeading != null && tempSelectedLocationPoint != null) {
        //print("here w");
        yield MainPointerStateLoaded(
            heading: mainPointerEvent.heading, currentPosition: mainPointerEvent.currentPosition, selectedLocationPoint: tempSelectedLocationPoint);
      }
    }

    if (mainPointerEvent is MainPointerEventErrorNoCompass) {
      yield MainPointerStateErrorNoCompass();
    }

    if (mainPointerEvent is MainPointerEventErrorPermissionDenied) {
      yield MainPointerStateErrorPermissionDenied();
      //permission = await Geolocator.requestPermission(); //todo запросить разрешение, вернуть эту строку? проверить появляется ли запрос на включение геопозиции
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
