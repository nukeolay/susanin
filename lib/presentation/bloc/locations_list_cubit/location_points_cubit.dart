import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location_points/usecases/load_locations.dart';
import 'package:susanin/domain/location_points/usecases/save_locations.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/location_points_state.dart';

class LocationPointsCubit extends Cubit<LocationPointsState> {
  final LoadLocations loadLocations;
  final SaveLocations saveLocations;

  LocationPointsCubit({
    required this.loadLocations,
    required this.saveLocations,
  }) : super(LocationPointsLoading());

  void loadLocationPoints() {
    // getMainPointer();
  }
}
