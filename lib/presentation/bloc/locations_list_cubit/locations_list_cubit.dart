import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/usecases/delete_location.dart';
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/domain/location_points/usecases/update_location.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';

class LocationsListCubit extends Cubit<LocationsListState> {
  final GetLocations _getLocations;
  final UpdateLocation _updateLocation;
  final DeleteLocation _deleteLocation;

  late final Stream<Either<Failure, List<LocationPointEntity>>>
      _locationsStream;

  LocationsListCubit({
    required GetLocations getLocations,
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
          final LocationsListState _state;
          if (failure is LoadLocationPointsFailure) {
            _state = state.copyWith(status: LocationsListStatus.loadFailure);
          } else if (failure is LocationPointExistsFailure) {
            _state = state.copyWith(
                status: LocationsListStatus.locationExistsFailure);
          } else if (failure is LocationPointRemoveFailure) {
            _state = state.copyWith(status: LocationsListStatus.removeFailure);
          } else if (failure is LocationPointRenameFailure) {
            _state = state.copyWith(status: LocationsListStatus.renameFailure);
          } else if (failure is LocationPointCreateFailure) {
            _state =
                state.copyWith(status: LocationsListStatus.locationAddFailure);
          } else {
            _state = state.copyWith(status: LocationsListStatus.unknownFailure);
          }
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

  void onDeleteLocation({required String pointName}) async {
    emit(state.copyWith(status: LocationsListStatus.loading));
    final deleteLocationResult = await _deleteLocation.call(pointName);
    deleteLocationResult.fold(
      (failure) {
        emit(state.copyWith(status: LocationsListStatus.removeFailure));
      },
      (result) {
        emit(state.copyWith(status: LocationsListStatus.loaded));
      },
    );
  }

  // void onUpdateLocation(
  //   double latitude,
  //   double longitude,
  //   String oldLocationName,
  //   String newLocationName,
  // ) async {
  //   emit(state.copyWith(status: LocationsListStatus.loading));
  //   final updateLocationResult = await _updateLocation(
  //     UpdateArgument(
  //       latitude: latitude,
  //       longitude: longitude,
  //       oldLocationName: oldLocationName,
  //       newLocationName: newLocationName,
  //     ),
  //   );
  // }
}
