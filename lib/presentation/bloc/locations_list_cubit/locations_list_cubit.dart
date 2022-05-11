import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/usecases/delete_location.dart';
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/domain/location_points/usecases/get_locations_stream.dart';
import 'package:susanin/domain/location_points/usecases/update_location.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings_stream.dart';
import 'package:susanin/domain/settings/usecases/set_active_location.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';

class LocationsListCubit extends Cubit<LocationsListState> {
  final GetLocationsStream _getLocationsStream;
  final GetSettingsStream _getSettingsStream;
  final UpdateLocation _updateLocation;
  final DeleteLocation _deleteLocation;
  final SetActiveLocation _setActiveLocation;
  final GetLocations _getLocations;
  final GetSettings _getSettings;

  late final StreamSubscription<Either<Failure, SettingsEntity>>
      _settingsSubscription;
  late final StreamSubscription<Either<Failure, List<LocationPointEntity>>>
      _locationsSubscription;

  LocationsListCubit({
    required GetSettingsStream getSettingsStream,
    required GetLocationsStream getLocationsStream,
    required UpdateLocation updateLocation,
    required DeleteLocation deleteLocation,
    required SetActiveLocation setActiveLocation,
    required GetLocations getLocations,
    required GetSettings getSettings,
  })  : _getSettingsStream = getSettingsStream,
        _getLocationsStream = getLocationsStream,
        _updateLocation = updateLocation,
        _deleteLocation = deleteLocation,
        _setActiveLocation = setActiveLocation,
        _getLocations = getLocations,
        _getSettings = getSettings,
        super(const LocationsListState(
          status: LocationsListStatus.loading,
          locations: [],
          activeLocationId: '',
        )) {
    _init();
  }

  void _init() {
    _settingHandler(_getSettings());
    _locationsHandler(_getLocations());
    _settingsSubscription = _getSettingsStream().listen(_settingHandler);
    _locationsSubscription = _getLocationsStream().listen(_locationsHandler);
  }

  void _settingHandler(Either<Failure, SettingsEntity> event) {
    event.fold(
      (failure) => emit(state.copyWith(status: LocationsListStatus.failure)),
      (settings) =>
          emit(state.copyWith(activeLocationId: settings.activeLocationId)),
    );
  }

  void _locationsHandler(Either<Failure, List<LocationPointEntity>> event) {
    event.fold(
      (failure) => emit(state.copyWith(status: LocationsListStatus.failure)),
      (locations) {
        emit(state.copyWith(
          status: LocationsListStatus.loaded,
          locations: locations,
        ));
      },
    );
  }

  @override
  Future<void> close() async {
    _locationsSubscription.cancel();
    _settingsSubscription.cancel();
    super.close();
  }

  Future<void> onDeleteLocation({required String id}) async {
    final deleteLocationResult = await _deleteLocation.call(id);
    deleteLocationResult.fold(
      (failure) {
        emit(state.copyWith(status: LocationsListStatus.failure));
      },
      (result) {
        emit(state.copyWith(status: LocationsListStatus.deleted));
      },
    );
  }

  void onPressSetActive({required String id}) async {
    _setActiveLocation(id);
    emit(state.copyWith(activeLocationId: id));
  }

  void onLongPressEdit({required String id}) async {
    final location =
        state.locations.firstWhere(((location) => location.id == id));
    _setActiveLocation(id);
    emit(EditLocationState(
      activeLocationId: id,
      id: id,
      status: LocationsListStatus.editing,
      name: location.name,
      latitude: location.latitude,
      longitude: location.longitude,
      locations: state.locations,
    ));
  }

  void onBottomSheetClose() {
    emit(state.copyWith(status: LocationsListStatus.loaded));
  }

  Future<void> onSaveLocation({
    required String id,
    required double latitude,
    required double longitude,
    required String newLocationName,
  }) async {
    final updateLocationResult = await _updateLocation(
      UpdateArgument(
        id: id,
        latitude: latitude,
        longitude: longitude,
        newLocationName: newLocationName,
      ),
    );
    updateLocationResult.fold(
        (failure) => emit(state.copyWith(status: LocationsListStatus.failure)),
        (r) => emit(state.copyWith(status: LocationsListStatus.updated)));
  }
}
