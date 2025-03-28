import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../features/places/domain/entities/icon_entity.dart';
import '../../../../../../features/places/domain/repositories/places_repository.dart';
import '../../../../../common/snackbar_error_handler.dart';
import '../../../../../common/state_fade_transition.dart';
import 'empty_location_list.dart';
import 'loading_location_list.dart';
import '../cubit/locations_list_cubit.dart';
import 'filled_location_list.dart';
import '../../../../../location_bottom_sheet/location_bottom_sheet.dart';

class LocationList extends StatelessWidget {
  const LocationList({super.key});

  @override
  Widget build(BuildContext context) {
    final placesRepository = context.read<PlacesRepository>();
    return BlocProvider(
      create:
          (_) => LocationsListCubit(placesRepository: placesRepository)..init(),
      child: const _LocationListWidget(),
    );
  }
}

class _LocationListWidget extends StatelessWidget {
  const _LocationListWidget();

  Widget _content(LocationsListState state) {
    if (state is! LocationsListLoadedState) {
      return const LoadingLocationList(key: ValueKey('LoadingLocationList'));
    }
    if (state.places.isEmpty) {
      return const EmptyLocationList(key: ValueKey('EmptyLocationList'));
    } else {
      return const FilledLocationList(key: ValueKey('FilledLocationList'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsListCubit, LocationsListState>(
      listener: (context, state) {
        if (state is! LocationsListLoadedState) {
          return;
        }
        if (state.status == LocationsListStatus.editing) {
          unawaited(
            _showBottomSheet(
              context,
              state,
            ).onError(SnackBarErrorHandler(context).onError),
          );
        } else if (state.status == LocationsListStatus.failure) {
          final snackBar = SnackBar(content: Text(context.s.error_unknown));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return StateFadeTransition(child: _content(state));
      },
    );
  }

  Future<void> _showBottomSheet(
    BuildContext context,
    LocationsListLoadedState state,
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
            saveLocation:
                ({
                  required String latitude,
                  required String longitude,
                  required String name,
                  required String notes,
                  required IconEntity icon,
                }) => cubit.onSaveLocation(
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
