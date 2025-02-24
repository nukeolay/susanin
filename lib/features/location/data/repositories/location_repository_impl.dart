import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/position_model.dart';
import '../services/permission_service.dart';
import '../services/location_service.dart';
import '../../domain/entities/position.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required LocationService locationService,
    required PermissionService permissionService,
  })  : _locationService = locationService,
        _permissionService = permissionService;

  final LocationService _locationService;
  final PermissionService _permissionService;
  final _streamController = BehaviorSubject<PositionEntity>();
  StreamSubscription<PositionModel>? _streamSubscription;

  void _initHandler() {
    _streamSubscription?.cancel();
    final stream = _locationService.positionStream;
    _streamSubscription = stream.listen(
      (event) {
        _streamController.add(
          PositionEntity.value(
            longitude: event.longitude,
            latitude: event.latitude,
            accuracy: event.accuracy,
          ),
        );
      },
      onError: (error) {
        if (error is LocationServiceDeniedException) {
          _streamController.add(const PositionEntity.notPermitted());
        } else if (error is LocationServiceDisabledException) {
          _streamController.add(const PositionEntity.disabled());
        } else {
          _streamController.add(const PositionEntity.unknownError());
        }
      },
    );
  }

  @override
  ValueStream<PositionEntity> get positionStream {
    _initHandler();
    return _streamController.stream;
  }

  @override
  Future<LocationStatus> requestPermission() async {
    final permission = await checkPermission();
    if (permission) {
      _initHandler();
      return LocationStatus.granted;
    }
    final isGranted = await _permissionService.requestPermission();
    final result =
        isGranted ? LocationStatus.granted : LocationStatus.notPermitted;
    _initHandler();
    return result;
  }

  @override
  Future<bool> checkPermission() {
    return _permissionService.checkPermission();
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    await _streamController.close();
    await _locationService.close();
  }
}
