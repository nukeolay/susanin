import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location_points/usecases/delete_location.dart';
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/domain/location_points/usecases/create_location.dart';
import 'package:susanin/domain/location_points/usecases/update_location.dart';
import 'package:susanin/presentation/bloc/locations_cubit/locations_state.dart';

class LocationsCubit extends Cubit<LocationPointsState> {
  final GetLocations getLocations;
  final CreateLocation createLocation;
  final UpdateLocation updateLocation;
  final DeleteLocation deleteLocation;

  LocationsCubit({
    required this.getLocations,
    required this.createLocation,
    required this.updateLocation,
    required this.deleteLocation,
  }) : super(const LocationPointsState(
          isLoading: true,
          locations: [],
        ));

  void loadLocationPoints() {
    // getMainPointer();
  }
}
