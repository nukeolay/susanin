import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass/flutter_compass.dart';

import 'compass_events.dart';
import 'compass_states.dart';

class CompassBloc extends Bloc<MyCompassEvent, CompassState> {
  Stream<CompassEvent> compassFlutterStream;

  CompassBloc(this.compassFlutterStream) : super(CompassStateInit());
  //todo что-то в init state не то

  @override
  Stream<CompassState> mapEventToState(MyCompassEvent myCompassEvent) async* {
    if (myCompassEvent is MyCompassEventAutoCompassLoading) {
      CompassEvent compassEvent = await compassFlutterStream.first;
      if (compassEvent == null) {
        yield CompassErrorStateNoCompass();
      } else if (compassEvent.heading != null) {
        yield CompassStateOk(compassFlutterStream);
      }
    }
  }
}
