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
      //работаем с потоком компасса
      _compassSubscription?.cancel(); //отменяем подписку на поток компасса, если по какой-то причине опять запщен ивент MainPointerEventGetServices
      _compassSubscription = _compassStream.listen((CompassEvent compassEvent) {
        //подписываемся на поток компасса
        add(MainPointerEventChanged(heading: compassEvent.heading)); //добавляем событие с углом пворота компасса
      }, onError: (e) => add(MainPointerEventErrorNoCompass())); //если ошибка в потоке компасса, то бодавляем событие с ошибкой компасса
      //работаем с потоком геолокации
      _positionSubscription
          ?.cancel(); //отменяем подписку на поток геолокации, если по какой-то причине опять запщен ивент MainPointerEventGetServices
      _positionSubscription = _positionStream.listen((Position position) async {
        add(MainPointerEventChanged(currentPosition: position)); //добавляем событие с текущей геолокацией
      }, onError: (e) async {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          add(MainPointerEventErrorServiceDisabled());
        }
      });
    }

    if (mainPointerEvent is MainPointerEventChanged) {
      //какие-то данные пришли из потока компасса и геолокации
      if (mainPointerEvent.heading == null) {
        yield MainPointerStateErrorNoCompass();
      } else {
        yield MainPointerStateLoaded(heading: mainPointerEvent.heading);
      }
      //todo Дописать работу с геолокацией, сейчас только компасс
    }

    if (mainPointerEvent is MainPointerEventErrorNoCompass) {
      yield MainPointerStateErrorNoCompass();
    }

    if (mainPointerEvent is MainPointerEventErrorPermissionDenied) {
      yield MainPointerStateErrorPermissionDenied();
      permission = await Geolocator.requestPermission(); //запросить разрешение
    }

    if (mainPointerEvent is MainPointerEventErrorPermissionDeniedForever) {
      yield MainPointerStateErrorPermissionDenied();
    }

    if (mainPointerEvent is MainPointerEventErrorServiceDisabled) {
      yield MainPointerStateErrorServiceDisabled();
    }

    if (mainPointerEvent is MainPointerEventSelectPoint)
    {
      yield MainPointerStateLoaded(selectedLocationPoint: mainPointerEvent.selectedLocationPoint);
    }
  }
}
