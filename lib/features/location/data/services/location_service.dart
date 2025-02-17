import 'dart:async';

import 'package:geolocator/geolocator.dart';

import 'package:susanin/core/errors/exceptions.dart' as susanin;
import 'package:susanin/features/location/data/models/position_model.dart';

abstract class LocationService {
  Stream<PositionModel> get positionStream;
  Future<void> close();
}

class LocationServiceImpl implements LocationService {
  LocationServiceImpl({
    this.accuracy = LocationAccuracy.best,
    this.distanceFilter = 0,
  });

  final LocationAccuracy accuracy;
  final int distanceFilter;

  final StreamController<PositionModel> _positionController =
      StreamController.broadcast();
  StreamSubscription<Position>? _positionSubscription;
  StreamSubscription<ServiceStatus>? _serviceSubscription;

  Future<void> _initPositionSubscription() async {
    await _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    ).listen(
      (event) {
        final model = PositionModel(
          longitude: event.longitude,
          latitude: event.latitude,
          accuracy: event.accuracy,
        );
        _positionController.add(model);
      },
    )..onError(
        (error) {
          if (error is LocationServiceDisabledException) {
            _positionController
                .addError(susanin.LocationServiceDisabledException());
          } else if (error is PermissionDeniedException) {
            _positionController
                .addError(susanin.LocationServiceDeniedException());
          } else {
            _positionController
                .addError(susanin.LocationServiceUnknownException());
          }
        },
      );
  }

  Future<void> _onServiceDisabled() async {
    _positionController.addError(
      susanin.LocationServiceDisabledException(),
    );
  }

  @override
  Stream<PositionModel> get positionStream {
    Geolocator.isLocationServiceEnabled().then(
      (isEnabled) {
        if (isEnabled) {
          _initPositionSubscription();
        } else {
          _onServiceDisabled();
        }
      },
    );
    _serviceSubscription ??= Geolocator.getServiceStatusStream().listen(
      (event) {
        final isEnabled = event == ServiceStatus.enabled;
        if (isEnabled) {
          _initPositionSubscription();
          return;
        } else {
          _onServiceDisabled();
        }
      },
    );
    return _positionController.stream;
  }

  @override
  Future<void> close() async {
    await _positionController.close();
    await _serviceSubscription?.cancel();
    await _positionSubscription?.cancel();
  }
}
