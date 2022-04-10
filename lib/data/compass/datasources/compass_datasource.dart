import 'package:flutter_compass/flutter_compass.dart';

import 'package:susanin/data/compass/models/compass_model.dart';

abstract class CompassDataSource {
  Stream<CompassModel> get compassStream;
}

// class CompassDataSourceImpl implements CompassDataSource {
//   @override
//   // ! TODO: implement compassStream
//   Stream<CompassModel> get compassStream {
//     double north;
//     Stream<CompassEvent>? compassEvents = FlutterCompass.events;
//     if(compassEvents != null) {
//       FlutterCompass.events!.map((event) => CompassModel(event.heading!));
//     }
    
//   };

// }