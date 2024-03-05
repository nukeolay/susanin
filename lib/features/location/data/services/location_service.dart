import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:susanin/core/errors/exceptions.dart' as susanin;
import 'package:susanin/features/location/data/models/position_model.dart';

abstract class LocationService {
  Stream<PositionModel> get positionStream;
}

class LocationServiceImpl implements LocationService {
  const LocationServiceImpl({
    required this.accuracy,
    required this.distanceFilter,
  });

  final LocationAccuracy accuracy;
  final int distanceFilter;

  @override
  Stream<PositionModel> get positionStream {
    // ! TODO слушать два стрима - позиуии и вкл выкл, эмитить в один контролле. Потому что если запустить прилодение первый раз с выключенным геолокатором, то после включеиня статус вкл не пявится, потому что еще нет разрешения
    final stream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
    return stream.transform(
      StreamTransformer.fromHandlers(
        handleData: (event, sink) {
          final model = PositionModel(
            longitude: event.longitude,
            latitude: event.latitude,
            accuracy: event.accuracy,
          );
          sink.add(model);
        },
        handleError: (error, stackTrace, sink) {
          if (error is LocationServiceDisabledException) {
            sink.addError(susanin.LocationServiceDisabledException());
          } else if (error is PermissionDeniedException) {
            sink.addError(susanin.LocationServiceDeniedException());
          } else {
            sink.addError(susanin.LocationServiceUnknownException());
          }
        },
      ),
    );
  }
}
