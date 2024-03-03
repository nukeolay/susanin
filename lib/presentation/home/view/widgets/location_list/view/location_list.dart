import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/places/domain/use_cases/delete_place.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/features/settings/domain/use_cases/get_active_place_stream.dart';
import 'package:susanin/features/settings/domain/use_cases/set_active_place.dart';
import 'package:susanin/presentation/home/view/widgets/location_bottom_sheet/view/location_bottom_sheet.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/filled_location_list.dart';

class LocationList extends StatelessWidget {
  const LocationList({required this.topPadding, super.key});
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final placesRepository = context.read<PlacesRepository>();
    final settingsRepository = context.read<SettingsRepository>();
    final getActivePlaceStream = GetActivePlaceStream(
      placesRepository: placesRepository,
      settingsRepository: settingsRepository,
    );
    final setActivePlace = SetActivePlace(settingsRepository);
    final deletePlace = DeletePlace(
      placesRepository: placesRepository,
      setActivePlace: setActivePlace,
      settingsRepository: settingsRepository,
    );
    return BlocProvider(
      create: (_) => LocationsListCubit(
        deletePlace: deletePlace,
        placesRepository: placesRepository,
        getActivePlaceStream: getActivePlaceStream,
        setActivePlace: setActivePlace,
      ),
      child: _LocationListWidget(topPadding: topPadding),
    );
  }
}

class _LocationListWidget extends StatelessWidget {
  const _LocationListWidget({required this.topPadding});
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<LocationsListCubit, LocationsListState>(
        listener: ((context, state) {
          if (state.status == LocationsListStatus.editing) {
            _showBottomSheet(context, state as EditPlaceState);
          } else if (state.status == LocationsListStatus.failure) {
            final snackBar = SnackBar(
              content: Text('error_unknown'.tr()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }),
        builder: ((context, state) {
          if (state.status == LocationsListStatus.loading) {
            return const SingleChildScrollView(
                child: CircularProgressIndicator());
          } else if (state.places.isEmpty) {
            return Center(
              child: Padding(
                padding:
                    EdgeInsets.only(top: topPadding, left: 12.0, right: 12.0),
                child: SingleChildScrollView(
                  child: Text(
                    'empty_locations_list'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          } else {
            return FilledLocationList(topPadding: topPadding);
          }
        }),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, EditPlaceState state) async {
    final cubit = context.read<LocationsListCubit>();
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LocationBottomSheet(
          name: state.name,
          latitude: state.latitude.toString(),
          longitude: state.longitude.toString(),
          saveLocation: ({
            required String latitude,
            required String longitude,
            required String name,
          }) =>
              cubit.onSaveLocation(
            latitude: latitude,
            longitude: longitude,
            newLocationName: name,
            id: state.activePlaceId,
          ),
        );
      },
    );
    cubit.onBottomSheetClose();
  }
}
