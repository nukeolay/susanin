import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/pointer/pointer_events.dart';
import 'package:susanin/domain/bloc/pointer/pointer_states.dart';
import 'package:susanin/domain/model/location_point.dart';

class PointerBloc extends Bloc<PointerEvent, PointerState> {
  LocationPoint selectedLocationPoint;
  double azimuth;
  double distance;
  Position lastPosition;
  double lastHeading;

  PointerBloc() : super(PointerStateInit());

  @override
  Stream<PointerState> mapEventToState(PointerEvent pointerEvent) async* {
    //print("pointerEvent: $pointerEvent"); //todo uncomment in debug
    if (pointerEvent is PointerEventInit) {
      yield PointerStateLoading();
    }

    if (pointerEvent is PointerEventEmptyList) {
      selectedLocationPoint = null;
      azimuth = null;
      distance = null;
      yield PointerStateEmptyList();
    }

    if (pointerEvent is PointerEventSetData) {
      lastHeading = pointerEvent.heading;
      lastPosition = pointerEvent.currentPosition;
      try {
        azimuth = pointerEvent.heading -
            Geolocator.bearingBetween(pointerEvent.currentPosition.latitude, pointerEvent.currentPosition.longitude,
                selectedLocationPoint.pointLatitude, selectedLocationPoint.pointLongitude);
        distance = Geolocator.distanceBetween(pointerEvent.currentPosition.latitude, pointerEvent.currentPosition.longitude,
            selectedLocationPoint.pointLatitude, selectedLocationPoint.pointLongitude);
        if (distance != null && azimuth != null && selectedLocationPoint != null) {
          yield PointerStateLoaded(distance: distance, azimuth: azimuth, selectedLocationPoint: selectedLocationPoint);
        }
      } catch (e) {
        yield PointerStateLoading();
      }
    }

    if (pointerEvent is PointerEventSelectPoint) {
      selectedLocationPoint = pointerEvent.selectedLocationPoint;
      add(PointerEventSetData(currentPosition: lastPosition, heading: lastHeading));
    }

    if (pointerEvent is PointerEventErrorNoCompass) {
      yield PointerStateErrorNoCompass();
    }

    if (pointerEvent is PointerEventErrorPermissionDenied) {
      yield PointerStateErrorPermissionDenied();
    }

    if (pointerEvent is PointerEventErrorPermissionDeniedForever) {
      yield PointerStateErrorPermissionDeniedForever();
    }

    if (pointerEvent is PointerEventErrorServiceDisabled) {
      yield PointerStateErrorServiceDisabled();
    }
  }
}
