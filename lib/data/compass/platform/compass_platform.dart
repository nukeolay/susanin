import 'package:flutter_compass/flutter_compass.dart';

import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/compass/models/compass_model.dart';

abstract class CompassPlatform {
  Stream<CompassModel> get compassStream;
}

class CompassPlatformImpl implements CompassPlatform {
  @override
  Stream<CompassModel> get compassStream {
    try {
      Stream<CompassEvent> compassEvents = FlutterCompass.events!;
      return compassEvents.map((event) => CompassModel(event.heading!));
    } catch (error) {
      throw CompassException();
    }
  }
}
