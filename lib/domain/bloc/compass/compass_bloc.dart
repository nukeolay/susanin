import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';

import 'compass_events.dart';
import 'compass_states.dart';

class MyCompassBloc extends Bloc<MyCompassEvent, MyCompassState> {
  Stream<CompassEvent> _compassStream;
  StreamSubscription<CompassEvent> _compassSubscription;

  MyCompassBloc(this._compassStream) : super(MyCompassStateLoading());

  @override
  Stream<MyCompassState> mapEventToState(MyCompassEvent myCompassEvent) async* {
    if (myCompassEvent is MyCompassEventGetCompass) {
      _compassSubscription?.cancel();
      _compassSubscription = _compassStream.listen(
        (CompassEvent compassEvent) => add(
          MyCompassEventHeadingChanged(heading: compassEvent.heading),
        ),
      );
    } else if (myCompassEvent is MyCompassEventHeadingChanged) {
      if (myCompassEvent.heading == null) {
        yield MyCompassStateError();
      } else {
        yield MyCompassStateLoaded(heading: myCompassEvent.heading);
      }
    }
  }
}
