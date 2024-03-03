import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/use_cases/add_place.dart';

part 'add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  AddLocationCubit({
    required AddPlace addPlace,
    required LocationRepository locationRepository,
  })  : _addPlace = addPlace,
        _locationRepository = locationRepository,
        super(AddLocationState.initial) {
    _init();
  }

  final AddPlace _addPlace;
  final LocationRepository _locationRepository;
  late final StreamSubscription<PositionEntity> _positionSubscription;

  void _init() {
    _positionSubscription = _locationRepository.positionStream.listen(
      _positionEventHandler,
    );
  }

  void _positionEventHandler(PositionEntity entity) {
    emit(state.copyWith(
      status: _locationStatusToAddLocationStatus(entity.status),
      latitude: entity.latitude,
      longitude: entity.longitude,
    ));
  }

  AddLocationStatus _locationStatusToAddLocationStatus(LocationStatus status) {
    switch (status) {
      case LocationStatus.disabled:
      case LocationStatus.notPermitted:
      case LocationStatus.unknownError:
        return AddLocationStatus.failure;
      case LocationStatus.loading:
        return AddLocationStatus.loading;
      case LocationStatus.granted:
        return AddLocationStatus.normal;
    }
  }

  @override
  Future<void> close() async {
    await _positionSubscription.cancel();
    super.close();
  }

  void onLongPressAdd() {
    emit(state.copyWith(
      status: AddLocationStatus.editing,
      name: _generateName(),
    ));
  }

  void onPressAdd() async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final addParams = AddParams(
      latitude: state.latitude,
      longitude: state.longitude,
      name: _generateName(),
    );
    await _addLocation(addParams);
  }

  Future<void> onSaveLocation({
    required String latitude,
    required String longitude,
    required String name,
  }) async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final doubleLatitude = double.tryParse(latitude);
    final doubleLongitude = double.tryParse(longitude);
    if (doubleLatitude == null || doubleLongitude == null) return;
    final addParams = AddParams(
      latitude: doubleLatitude,
      longitude: doubleLongitude,
      name: name,
    );
    await _addLocation(addParams);
  }

  Future<void> _addLocation(AddParams addParams) async {
    try {
      await _addPlace(addParams);
      emit(state.copyWith(status: AddLocationStatus.normal));
    } catch (error) {
      emit(state.copyWith(status: AddLocationStatus.failure));
    }
  }

  String _generateName() {
    final dateTime = DateTime.now().toString();
    return 'point ${dateTime.substring(dateTime.length - 6)}';
  }
}
