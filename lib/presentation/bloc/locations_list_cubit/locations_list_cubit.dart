import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/usecases/delete_location.dart';
import 'package:susanin/domain/location_points/usecases/get_locations_stream.dart';
import 'package:susanin/domain/location_points/usecases/update_location.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';

class LocationsListCubit extends Cubit<LocationsListState> {
  final GetLocationsStream _getLocations;
  final UpdateLocation _updateLocation;
  final DeleteLocation _deleteLocation;

  late final Stream<Either<Failure, List<LocationPointEntity>>>
      _locationsStream;

  LocationsListCubit({
    required GetLocationsStream getLocations,
    required UpdateLocation updateLocation,
    required DeleteLocation deleteLocation,
  })  : _getLocations = getLocations,
        _updateLocation = updateLocation,
        _deleteLocation = deleteLocation,
        super(const LocationsListState(
          status: LocationsListStatus.loading,
          locations: [],
        )) {
    _init();
  }

  void _init() {
    _locationsStream = _getLocations();
    _locationsStream.listen((event) {
      event.fold(
        (failure) {
          emit(state.copyWith(status: LocationsListStatus.failure));
        },
        (locations) {
          emit(state.copyWith(
            status: LocationsListStatus.loaded,
            locations: locations,
          ));
        },
      );
    });
  }

  Future<void> onDeleteLocation({required String pointName}) async {
    final deleteLocationResult = await _deleteLocation.call(pointName);
    deleteLocationResult.fold(
      (failure) {
        emit(state.copyWith(status: LocationsListStatus.failure));
      },
      (result) {
        emit(state.copyWith(status: LocationsListStatus.deleted));
      },
    );
  }

  void onLongPressEdit({
    required String name,
    required double latitude,
    required double longitude,
  }) async {
    emit(EditLocationState(
      status: LocationsListStatus.editing,
      pointName: name,
      latitude: latitude,
      longitude: longitude,
      locations: state.locations,
    ));
  }

  void onBottomSheetClose() {
    emit(state.copyWith(status: LocationsListStatus.loaded));
  }

  Future<void> onSaveLocation({
    required double latitude,
    required double longitude,
    required String oldLocationName,
    required String newLocationName,
  }) async {
    final updateLocationResult = await _updateLocation(
      UpdateArgument(
        latitude: latitude,
        longitude: longitude,
        oldLocationName: oldLocationName,
        newLocationName: newLocationName,
      ),
    );
    updateLocationResult.fold(
        (failure) => emit(state.copyWith(status: LocationsListStatus.failure)),
        (r) => emit(state.copyWith(status: LocationsListStatus.updated)));
  }
}
