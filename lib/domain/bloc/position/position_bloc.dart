import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/position/position_events.dart';
import 'package:susanin/domain/bloc/position/position_states.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  StreamSubscription<Position> _positionSubscription;

  //Stream<Position> positionStream;

  //StreamSubscription<Position> positionSubscription;

  PositionBloc() : super(PositionStateLoading());

  @override
  Stream<PositionState> mapEventToState(PositionEvent positionEvent) async* {
    bool serviceEnabled;
    LocationPermission permission;
    if (positionEvent is PositionEventGetLocationService) {
      _positionSubscription?.cancel();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();

      if (!serviceEnabled) {
        add(PositionEventErrorServiceDisabled());
      }
      _positionSubscription = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation).listen((Position position) async {
        //if (!serviceEnabled) {
        //add(PositionEventErrorServiceDisabled());
        //}
        // if (permission == LocationPermission.deniedForever) {
        //   add(PositionEventErrorPermissionDenied());
        // } else if (permission == LocationPermission.denied) {
        //   permission = await Geolocator.requestPermission();
        //   if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        //     add(PositionEventErrorPermissionDenied());
        //   } else {
        add(PositionEventLocationChanged(position: position));
      }, onError: (e) async {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          add(PositionEventErrorServiceDisabled());
        }
      });
    } else if (positionEvent is PositionEventLocationChanged) {
      yield PositionStateLoaded(currentPosition: positionEvent.position);
    } else if (positionEvent is PositionEventErrorPermissionDenied) {
      yield PositionStateErrorPermissionDenied();
    } else if (positionEvent is PositionEventErrorServiceDisabled) {
      yield PositionStateErrorServiceDisabled();
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
