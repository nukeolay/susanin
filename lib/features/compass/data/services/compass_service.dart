import 'dart:async';

import 'package:flutter_compass/flutter_compass.dart';

import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/features/compass/data/models/compass_model.dart';

abstract class CompassService {
  Stream<CompassModel> get compassStream;
}

class CompassServiceImpl implements CompassService {
  const CompassServiceImpl();

  @override
  Stream<CompassModel> get compassStream {
    final compassStream = FlutterCompass.events;
    if (compassStream == null) {
      // This device has no compass
      throw CompassException();
    }
    return compassStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (event, sink) {
          final model = CompassModel(
            north: event.heading!,
            accuracy: event.accuracy!,
          );
          sink.add(model);
        },
      ),
    );
  }
}
