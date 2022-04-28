import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
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
        child: BlocBuilder<LocationsListCubit, LocationsListState>(
            builder: ((context, state) {
          if (state.status == LocationsListStatus.loading) {
            return const CircularProgressIndicator();
          } else if (state.status == LocationsListStatus.loadFailure ||
              state.status == LocationsListStatus.removeFailure ||
              state.status == LocationsListStatus.renameFailure ||
              state.status == LocationsListStatus.locationAddFailure ||
              state.status == LocationsListStatus.locationExistsFailure) {
            return Text(state.status.toString());
          } else if (state.locations.isEmpty) {
            return const Text('There is no locations saved');
          } else {
            final locations = state.locations;
            return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final key = ValueKey(locations[index].pointName);
                  return LocationListItem(
                    location: locations[index],
                    key: key,
                  );
                });
          }
        })),
      ),
    );
  }
}
