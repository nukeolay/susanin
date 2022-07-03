import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:susanin/core/errors/exceptions.dart' as susanin;
import 'package:susanin/data/location/models/position_model.dart';

abstract class PositionPlatform {
  Stream<PositionModel> get positionStream;
  void close();
}

class PositionPlatformStreamImpl implements PositionPlatform {
  final locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

  final StreamController<PositionModel> _streamController =
      StreamController.broadcast();

  @override
  Stream<PositionModel> get positionStream {
    _init();
    return _streamController.stream;
  }

  void _init() async {
    final permission = await Geolocator.checkPermission();
    final isGranted = permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    bool isReady = true;
    if (!isGranted) {
      _streamController.addError(susanin.LocationServiceDeniedException());
      isReady = false;
    }
    if (!isEnabled) {
      _streamController.addError(susanin.LocationServiceDisabledException());
      isReady = false;
    }
    isReady ? _getStream() : await _tryInit();
  }

  Future<void> _tryInit() async {
    return Future.delayed(const Duration(milliseconds: 500), () => _init());
  }

  void _getStream() {
    PositionModel? _lastKnownPosition;
    Geolocator.getServiceStatusStream().listen((event) {
      if (event == ServiceStatus.disabled) {
        _streamController.addError(susanin.LocationServiceDisabledException());
      }
      if (event == ServiceStatus.enabled && _lastKnownPosition != null) {
        _streamController.add(_lastKnownPosition!);
      }
    }).onError((error) async {});

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((event) {
      _lastKnownPosition = PositionModel(
        longitude: event.longitude,
        latitude: event.latitude,
        accuracy: event.accuracy,
      );
      _streamController.add(_lastKnownPosition!);
    }).onError((error) {});
  }

  @override
  void close() {
    _streamController.close();
  }
}

// old version of position stream
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
