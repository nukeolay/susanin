import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';

import 'compass_events.dart';
import 'compass_states.dart';

class MyCompassBloc extends Bloc<MyCompassEvent, MyCompassState> {
  Stream<CompassEvent> compassStream;

  //FlutterCompass flutterCompass;

  MyCompassBloc(this.compassStream) : super(MyCompassStateLoading());

  @override
  Stream<MyCompassState> mapEventToState(MyCompassEvent myCompassEvent) async* {
    if (myCompassEvent is MyCompassEventGetCompass) {
      try {
        CompassEvent compassEvent = await compassStream.first;
        double heading = compassEvent.heading;
        yield MyCompassStateLoaded(compassStream);
      } catch (e) {
        print("compass error: $e");
        yield MyCompassStateError();
      }
    } else if (myCompassEvent is MyCompassEventError) {
      yield MyCompassStateError();
    }
  }
}
