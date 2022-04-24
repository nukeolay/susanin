import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/usecases/delete_location.dart';
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/domain/location_points/usecases/add_location.dart';
import 'package:susanin/domain/location_points/usecases/update_location.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';

class LocationsListCubit extends Cubit<LocationsListState> {
  final GetLocations _getLocations;
  final AddLocation _addLocation;
  final UpdateLocation _updateLocation;
  final DeleteLocation _deleteLocation;

  late final Stream<Either<Failure, List<LocationPointEntity>>>
      _locationsStream;

  LocationsListCubit({
    required GetLocations getLocations,
    required AddLocation addLocation,
    required UpdateLocation updateLocation,
    required DeleteLocation deleteLocation,
  })  : _getLocations = getLocations,
        _addLocation = addLocation,
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
          // if (failure is LoadLocationPointsFailure) {
          //   //
          // } else if (failure is LocationPointExistsFailure) {
          //   //
          // } else if (failure is LocationPointRemoveFailure) {
          //   //
          // } else if (failure is LocationPointRenameFailure) {
          //   //
          // } else if (failure is LocationPointCreateFailure) {
          //   //
          // } else {
          //   //
          // }
          final _state =
              state.copyWith(status: LocationsListStatus.loadFailure);
          emit(_state);
        },
        (locations) {
          final _state = state.copyWith(
            status: LocationsListStatus.loaded,
            locations: locations,
          );
          emit(_state);
        },
      );
    });
  }

  void updateLocation(
    double latitude,
    double longitude,
    String oldLocationName,
    String newLocationName,
  ) async {
    emit(state.copyWith(status: LocationsListStatus.loading));
    final updateLocationResult = await _updateLocation(
      UpdateArgument(
        latitude: latitude,
        longitude: longitude,
        oldLocationName: oldLocationName,
        newLocationName: newLocationName,
      ),
    );
  }
}
