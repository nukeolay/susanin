import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
import 'package:susanin/presentation/screens/home/widgets/location_bottom_sheet.dart';
import 'package:susanin/presentation/screens/home/widgets/location_list_item.dart';

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
        child: BlocConsumer<LocationsListCubit, LocationsListState>(
          listener: ((context, state) {
            if (state.status == LocationsListStatus.editing) {
              _showBottomSheet(context, state as EditLocationState);
            } else if (state.status == LocationsListStatus.failure) {
              const snackBar = SnackBar(
                content: Text('Error handling action'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }),
          builder: ((context, state) {
            if (state.status == LocationsListStatus.loading) {
              return const CircularProgressIndicator();
            } else if (state.locations.isEmpty) {
              return const Text('There is no locations saved');
            } else {
              final locations = state.locations;
              return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final key = ValueKey(
                        locations[locations.length - index - 1].name);
                    return LocationListItem(
                      location: locations[locations.length - index - 1],
                      key: key,
                    );
                  });
            }
          }),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, EditLocationState state) async {
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
          ) async {
            await context.read<LocationsListCubit>().onSaveLocation(
                  latitude: double.parse(latitude),
                  longitude: double.parse(longitude),
                  newLocationName: name,
                  id: state.id,
                );
          },
        );
      },
    );
    context.read<LocationsListCubit>().onBottomSheetClose();
  }
}
