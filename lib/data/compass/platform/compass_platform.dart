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
    print('CALLED PLATFORM COMPASS 1');
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
        // print(event);
        _streamController.add(CompassModel(
          north: event.heading!,
          accuracy: event.accuracy!,
        ));
      }).onError((error) {
        print(error.toString());
        throw CompassException();
      });
    } catch (error) {
      print(error.toString());
      throw CompassException();
    }
  }

  @override
  Future<void> close() async {
    await _streamController.close();
  }
}

// class CompassPlatformImpl implements CompassPlatform {
//   CompassPlatformImpl() {
//     print('CALLED PLATFORM COMPASS 1');
//   }
//   @override
//   Stream<CompassModel> get compassStream {
//     print('CALLED PLATFORM COMPASS 2');
//     try {
//       Stream<CompassEvent> compassEvents = FlutterCompass.events!;
//       return compassEvents.map((event) {
//         // print(event);
//         return CompassModel(
//           north: event.heading!,
//           accuracy: event.accuracy!,
//         );
//       });
//     } catch (error) {
//       print(error.toString());
//       throw CompassException();
//     }
//   }
// }