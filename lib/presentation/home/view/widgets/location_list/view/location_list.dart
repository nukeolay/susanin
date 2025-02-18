import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/places/domain/entities/icon_entity.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/empty_location_list.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/loading_location_list.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/filled_location_list.dart';
import 'package:susanin/presentation/location_bottom_sheet/location_bottom_sheet.dart';

class LocationList extends StatelessWidget {
  const LocationList({super.key});

  @override
  Widget build(BuildContext context) {
    final placesRepository = context.read<PlacesRepository>();
    return BlocProvider(
      create: (_) => LocationsListCubit(
        placesRepository: placesRepository,
      )..init(),
      child: const _LocationListWidget(),
    );
  }
}

class _LocationListWidget extends StatelessWidget {
  const _LocationListWidget();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsListCubit, LocationsListState>(
      listener: (context, state) {
        if (state.status == LocationsListStatus.editing) {
          _showBottomSheet(context, state);
        } else if (state.status == LocationsListStatus.failure) {
          final snackBar = SnackBar(
            content: Text(context.s.error_unknown),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state.status == LocationsListStatus.loading) {
          return const LoadingLocationList();
        } else if (state.places.isEmpty) {
          return const EmptyLocationList();
        } else {
          return const FilledLocationList();
        }
      },
    );
  }

  Future<void> _showBottomSheet(
    BuildContext context,
    LocationsListState state,
  ) async {
    final activePlace = state.activePlace;
    if (activePlace == null) {
      return;
    }
    final cubit = context.read<LocationsListCubit>();
    await context.showSusaninBottomSheet(
      context: context,
      builder: (ctx) {
        return LocationBottomSheet(
          model: LocationBottomSheetModel(
            id: activePlace.id,
            name: activePlace.name,
            icon: activePlace.icon,
            latitude: activePlace.latitude,
            longitude: activePlace.longitude,
            notes: activePlace.notes,
            saveLocation: ({
              required String latitude,
              required String longitude,
              required String name,
              required String notes,
              required IconEntity icon,
            }) =>
                cubit.onSaveLocation(
              latitude: latitude,
              longitude: longitude,
              notes: notes,
              newLocationName: name,
              icon: icon,
              id: state.activePlaceId,
            ),
          ),
        );
      },
    );
    cubit.onBottomSheetClose();
  }
}
