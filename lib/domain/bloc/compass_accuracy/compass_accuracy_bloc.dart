import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'compass_accuracy_events.dart';
import 'compass_accuracy_states.dart';

class CompassAccuracyBloc extends Bloc<CompassAccuracyEvent, CompassAccuracyState> {
  Stream<CompassEvent> _compassStream;
  StreamSubscription<CompassEvent> _compassSubscription;

  Stream<Position> _positionStream;
  StreamSubscription<Position> _positionSubscription;

  LocationPermission permission;
  bool serviceEnabled;

  Position tempCurrentPosition;
  double tempCurrentHeading;

  CompassAccuracyBloc(this._compassStream, this._positionStream) : super(CompassAccuracyStateInit());

  @override
  Stream<CompassAccuracyState> mapEventToState(CompassAccuracyEvent compassAccuracyEvent) async* {
    //print("compassAccuracyEvent: $compassAccuracyEvent"); //todo uncomment in debug
    if (compassAccuracyEvent is CompassAccuracyEventCheckPermissionsOnOff) {
      //проверка разрешений
      //print('PermissionOnOff'); //todo uncomment in debug
      permission = await Geolocator.checkPermission();
      //print("permission: $permission"); //todo uncomment in debug
      if (permission == LocationPermission.deniedForever) {
        //если разрешение заблокировано
        add(CompassAccuracyEventErrorPermissionDeniedForever());
      } else if (permission == LocationPermission.denied) {
        //если разрешение не выдано один раз
        add(CompassAccuracyEventErrorPermissionDenied());
        await Geolocator.requestPermission();
        //permission = await Geolocator.checkPermission();
      } else {
        //если с разрешением все норм, то проверяем включен ли сервис геолокации
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          add(CompassAccuracyEventErrorServiceDisabled());
        } else {
          add(CompassAccuracyEventGetServices());
        }
      }
    }

    if (compassAccuracyEvent is CompassAccuracyEventGetServices) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        add(CompassAccuracyEventErrorServiceDisabled());
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
        add(CompassAccuracyEventChanged(heading: compassEvent.heading, currentPosition: tempCurrentPosition));
      }, onError: (compassError) {
        _positionSubscription?.pause();
        add(CompassAccuracyEventErrorNoCompass());
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
        add(CompassAccuracyEventChanged(heading: tempCurrentHeading, currentPosition: position));
      }, onError: (locationError) async {
        _compassSubscription?.pause();
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          add(CompassAccuracyEventErrorServiceDisabled());
        }
      });
    }

    if (compassAccuracyEvent is CompassAccuracyEventChanged) {
      //какие-то данные пришли из потока компасса и геолокации
      if (compassAccuracyEvent.currentPosition != null && compassAccuracyEvent.heading != null) {
        yield CompassAccuracyStateLoaded(heading: compassAccuracyEvent.heading, currentPosition: compassAccuracyEvent.currentPosition);
      }
    }

    if (compassAccuracyEvent is CompassAccuracyEventErrorNoCompass) {
      yield CompassAccuracyStateErrorNoCompass();
    }

    if (compassAccuracyEvent is CompassAccuracyEventErrorPermissionDenied) {
      yield CompassAccuracyStateErrorPermissionDenied();
    }

    if (compassAccuracyEvent is CompassAccuracyEventErrorPermissionDeniedForever) {
      yield CompassAccuracyStateErrorPermissionDeniedForever();
    }

    if (compassAccuracyEvent is CompassAccuracyEventErrorServiceDisabled) {
      yield CompassAccuracyStateErrorServiceDisabled();
    }
  }
}
