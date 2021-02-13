import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/position/position_events.dart';
import 'package:susanin/domain/bloc/position/position_states.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  StreamSubscription<Position> _positionSubscription;

  PositionBloc() : super(PositionStateLoading());

  @override
  Stream<PositionState> mapEventToState(PositionEvent positionEvent) async* {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      yield PositionStateErrorPermissionDenied();
    } else if (permission == LocationPermission.denied) {
      yield PositionStateErrorPermissionDenied();
      permission = await Geolocator.requestPermission();
    }
    if (positionEvent is PositionEventLocationChanged) {
      yield PositionStateLoaded(currentPosition: positionEvent.position);
    } else if (positionEvent is PositionEventErrorServiceDisabled) {
      yield PositionStateErrorServiceDisabled();
    } else if (positionEvent is PositionEventGetLocationService) {
      _positionSubscription?.cancel();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // if (!serviceEnabled) {
      //   yield PositionStateErrorServiceDisabled();
      // }
      _positionSubscription = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation).listen((Position position) async {
        add(PositionEventLocationChanged(position: position));
      }, onError: (e) async {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          add(PositionEventErrorServiceDisabled());
        }
      });
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
