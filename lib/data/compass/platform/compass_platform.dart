import 'dart:async';

import 'package:flutter_compass/flutter_compass.dart';

import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/data/compass/models/compass_model.dart';

abstract class CompassPlatform {
  Stream<CompassModel> get compassStream;
  Future<void> close();
}

class CompassPlatformImpl implements CompassPlatform {
  final StreamController<CompassModel> _streamController =
      StreamController.broadcast();

  CompassPlatformImpl() {
    _init();
  }
  
  @override
  Stream<CompassModel> get compassStream => _streamController.stream;

  void _init() {
    if (FlutterCompass.events == null) {
      // This device has no compass
      throw CompassException();
    }
    try {
      FlutterCompass.events!.listen((event) {
        _streamController.add(CompassModel(
          north: event.heading!,
          accuracy: event.accuracy!,
        ));
      }).onError((error) {
        throw CompassException();
      });
    } catch (error) {
      throw CompassException();
    }
  }

  @override
  Future<void> close() async {
    await _streamController.close();
  }
}
