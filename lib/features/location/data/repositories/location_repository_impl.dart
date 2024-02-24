import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/location/data/services/permission_service.dart';
import 'package:susanin/features/location/data/services/location_service.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required LocationService locationService,
    required PermissionService permissionService,
  })  : _locationService = locationService,
        _permissionService = permissionService;

  final LocationService _locationService;
  final PermissionService _permissionService;
  final _streamController = BehaviorSubject<PositionEntity>();
  StreamSubscription<PositionEntity>? _streamSubscription;

  void _initHandler() {
    _streamSubscription?.cancel();
    final stream = _locationService.positionStream;
    _streamSubscription = stream.listen((event) {
      _streamController.add(event);
    }, onError: (error) {
      _streamController.addError(error);
    });
  }

  @override
  ValueStream<PositionEntity> get positionStream {
    _initHandler();
    return _streamController.stream;
  }

  @override
  Future<bool> requestPermission() async {
    final result = await _permissionService.requestPermission();
    _initHandler();
    return result;
  }

  @override
  Future<bool> checkPermission() {
    return _permissionService.checkPermission();
  }
}
