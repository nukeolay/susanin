import 'package:flutter_compass/flutter_compass.dart';

import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/compass/models/compass_model.dart';

abstract class CompassPlatform {
  Stream<CompassModel> get compassStream;
}

class CompassPlatformImpl implements CompassPlatform {
  CompassPlatformImpl() {
    print('CALLED PLATFORM COMPASS 1');
  }
  @override
  Stream<CompassModel> get compassStream {
    print('CALLED PLATFORM COMPASS 2');
    try {
      Stream<CompassEvent> compassEvents = FlutterCompass.events!;
      return compassEvents.map((event) {
        // print(event);
        return CompassModel(
          north: event.heading!,
          accuracy: event.accuracy!,
        );
      });
    } catch (error) {
      print(error.toString());
      throw CompassException();
    }
  }
}
