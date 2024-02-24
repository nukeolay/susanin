import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/places/domain/use_cases/add_place.dart';

part 'add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  AddLocationCubit({
    required AddPlace addPlace,
    required GetPositionStream getPositionStream,
  })  : _addPlace = addPlace,
        _getPositionStream = getPositionStream,
        super(AddLocationState.initial) {
    _init();
  }

  final AddPlace _addPlace;
  final GetPositionStream _getPositionStream;
  late final StreamSubscription<PositionEvent> _positionSubscription;

  void _init() {
    _positionSubscription = _getPositionStream(const NoParams()).listen(
      _positionEventHandler,
    );
  }

  void _positionEventHandler(PositionEvent event) {
    final position = event.entity;
    final status = event.status;
    emit(state.copyWith(
      status: _locationStatusToAddLocationStatus(status),
      latitude: position?.latitude,
      longitude: position?.longitude,
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

  void onSaveLocation({
    required double latitude,
    required double longitude,
    required String name,
  }) async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final addParams = AddParams(
      latitude: latitude,
      longitude: longitude,
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
