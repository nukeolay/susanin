import 'package:flutter_compass/flutter_compass.dart';

import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/compass/models/compass_model.dart';

abstract class CompassPlatform {
  Stream<CompassModel> get compassStream;
}

class CompassPlatformImpl implements CompassPlatform {
  @override
  Stream<CompassModel> get compassStream {
    print('CALLED PLATFORM COMPASS');
    try {
      Stream<CompassEvent> compassEvents = FlutterCompass.events!;
      compassStream.listen((event) {
        print('--COMPASS EVENT: $event');
      });
      return compassEvents.map((event) => CompassModel(
            north: event.heading!,
            accuracy: event.accuracy!,
          ));
    } catch (error) {
      throw CompassException();
    }
  }
}
