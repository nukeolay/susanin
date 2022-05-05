import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location_points/usecases/add_location.dart';
import 'package:susanin/domain/settings/usecases/set_active_location.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  final AddLocation _addLocation;
  final GetPositionStream _getPositionStream;
  late final Stream<Either<Failure, PositionEntity>> _positionStream;
  late final StreamSubscription<Either<Failure, PositionEntity>>
      _positionSubscription;

  AddLocationCubit({
    required AddLocation addLocation,
    required GetPositionStream getPositionStream,
  })  : _addLocation = addLocation,
        _getPositionStream = getPositionStream,
        super(const AddLocationState(
          status: AddLocationStatus.loading,
          latitude: 0,
          longitude: 0,
          name: '',
        )) {
    _init();
  }

  void _init() {
    _positionStream = _getPositionStream();
    _positionSubscription = _positionStream.listen((event) {
      event.fold((failure) {
        emit(state.copyWith(status: AddLocationStatus.failure));
      }, (position) {
        emit(state.copyWith(
          status: AddLocationStatus.normal,
          latitude: position.latitude,
          longitude: position.longitude,
        ));
      });
    });
  }

  @override
  Future<void> close() async {
    _positionSubscription.cancel();
    super.close();
  }

  void onLongPressAdd() async {
    emit(state.copyWith(
      status: AddLocationStatus.editing,
      latitude: state.latitude,
      longitude: state.longitude,
      name: DateTime.now().toString(),
    ));
  }

  void onPressAdd() async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final addLocationResult = await _addLocation(LocationArgument(
        latitude: state.latitude,
        longitude: state.longitude,
        name: DateTime.now().toString()));
    addLocationResult.fold(
      (failure) => emit(state.copyWith(status: AddLocationStatus.failure)),
      (result) {
        emit(state.copyWith(status: AddLocationStatus.normal));
      },
    );
  }

  void onSaveLocation({
    required double latitude,
    required double longitude,
    required String name,
  }) async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final addLocationResult = await _addLocation(
        LocationArgument(latitude: latitude, longitude: longitude, name: name));
    addLocationResult.fold(
      (failure) {
        emit(state.copyWith(status: AddLocationStatus.failure));
      },
      (result) {
        emit(state.copyWith(status: AddLocationStatus.normal));
      },
    );
  }
}
