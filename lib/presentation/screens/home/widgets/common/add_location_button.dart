import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/location_bottom_sheet.dart';

class AddNewLocationButton extends StatelessWidget {
  const AddNewLocationButton({Key? key}) : super(key: key);

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
          saveLocation: (
            String latitude,
            String longitude,
            String name,
          ) {
            context.read<AddLocationCubit>().onSaveLocation(
                  latitude: double.parse(latitude),
                  longitude: double.parse(longitude),
                  name: name,
                );
          },
        );
      },
    );
  }
}
