import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:susanin/core/errors/exceptions.dart' as susanin;
import 'package:susanin/data/location/models/position_model.dart';

abstract class PositionPlatform {
  Stream<PositionModel> get positionStream;
  void close();
}

class PositionPlatformImpl implements PositionPlatform {
  bool _isClosed = false;

  @override
  Stream<PositionModel> get positionStream async* {
    bool isServiceEnabled;
    LocationPermission permission;
    while (!_isClosed) {
      await Future.delayed(const Duration(
          milliseconds: 1000)); // pause before retrive next location
      try {
        isServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isServiceEnabled) {
          throw const LocationServiceDisabledException();
        }
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw const PermissionDeniedException(null);
        }

        Position position = await Geolocator.getCurrentPosition();
        yield PositionModel(
          longitude: position.longitude,
          latitude: position.latitude,
          accuracy: position.accuracy,
        );
      } on LocationServiceDisabledException {
        throw susanin.LocationServiceDisabledException();
      } on PermissionDeniedException {
        throw susanin.LocationServiceDeniedException();
      } catch (error) {
        throw susanin.SusaninException();
      }
    }
  }

  @override
  void close() {
    _isClosed = true;
  }
}

class PositionPlatformImplAlt implements PositionPlatform {
  final locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  PositionPlatformImplAlt() {
    _init();
  }

  final StreamController<PositionModel> _streamController =
      StreamController.broadcast();

  @override
  Stream<PositionModel> get positionStream => _streamController.stream;

  void _init() async {
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((event) {
      _streamController.add(PositionModel(
        longitude: event.longitude,
        latitude: event.latitude,
        accuracy: event.accuracy,
      ));
    }).onError((error) {
      if (error is PermissionDeniedException ||
          error is InvalidPermissionException) {
        _streamController.addError(susanin.LocationServiceDeniedException());
      } else if (error is LocationServiceDisabledException) {
        _streamController.addError(susanin.LocationServiceDisabledException());
      } else {
        _streamController.addError(susanin.SusaninException());
      }
    });
  }

  @override
  void close() {
    _streamController.close();
  }
}
