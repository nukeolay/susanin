import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/places/domain/use_cases/add_place.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/features/settings/domain/use_cases/set_active_place.dart';
import 'package:susanin/presentation/home/view/widgets/add_location_button/cubit/add_location_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/location_bottom_sheet/view/location_bottom_sheet.dart';

class AddNewLocationButton extends StatelessWidget {
  const AddNewLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final setActivePlace = SetActivePlace(
      context.read<SettingsRepository>(),
    );
    final addPlace = AddPlace(
      placesRepository: context.read<PlacesRepository>(),
      setActivePlace: setActivePlace, // ! TODO usecase depends on usecase
    );
    final locationRepository = context.read<LocationRepository>();
    return BlocProvider(
      create: (_) => AddLocationCubit(
        addPlace: addPlace,
        locationRepository: locationRepository,
      ),
      child: const _AddNewLocationButtonWidget(),
    );
  }
}

class _AddNewLocationButtonWidget extends StatelessWidget {
  const _AddNewLocationButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddLocationCubit, AddLocationState>(
      listenWhen: ((previous, current) {
        return current.status == AddLocationStatus.editing;
      }),
      listener: ((context, state) {
        _showBottomSheet(context, state);
      }),
      builder: ((context, state) {
        if (state.status == AddLocationStatus.loading) {
          return FloatingActionButton(
            onPressed: null,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          );
        } else if (state.status == AddLocationStatus.failure) {
          return FloatingActionButton(
            onPressed: null,
            backgroundColor: Theme.of(context).disabledColor,
            child: const Icon(Icons.not_interested_rounded),
          );
        }
        return GestureDetector(
          onLongPress: () {
            HapticFeedback.heavyImpact();
            context.read<AddLocationCubit>().onLongPressAdd();
          },
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            onPressed: () {
              HapticFeedback.heavyImpact();
              context.read<AddLocationCubit>().onPressAdd();
            },
            child: const Icon(Icons.add_location_alt_rounded),
          ),
        );
      }),
    );
  }

  void _showBottomSheet(BuildContext context, AddLocationState state) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LocationBottomSheet(
          name: state.name,
          latitude: state.latitude.toString(),
          longitude: state.longitude.toString(),
          saveLocation: context.read<AddLocationCubit>().onSaveLocation,
        );
      },
    );
  }
}
