import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../../../../core/errors/exceptions.dart' as susanin;
import '../models/position_model.dart';

abstract class LocationService {
  Stream<PositionModel> get positionStream;
  Future<void> close();
}

class LocationServiceImpl implements LocationService {
  LocationServiceImpl({
    LocationAccuracy accuracy = LocationAccuracy.best,
    int distanceFilter = 0,
  })  : _distanceFilter = distanceFilter,
        _accuracy = accuracy;

  final LocationAccuracy _accuracy;
  final int _distanceFilter;

  final StreamController<PositionModel> _positionController =
      StreamController.broadcast();
  StreamSubscription<Position>? _positionSubscription;
  StreamSubscription<ServiceStatus>? _serviceSubscription;

  Future<void> _initPositionSubscription() async {
    await _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: _accuracy,
        distanceFilter: _distanceFilter,
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
