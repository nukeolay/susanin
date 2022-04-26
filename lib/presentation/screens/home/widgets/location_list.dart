import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';

class LocationList extends StatelessWidget {
  const LocationList({ Key? key }) : super(key: key);

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
                    } else if (state.status ==
                            LocationsListStatus.loadFailure ||
                        state.status == LocationsListStatus.removeFailure ||
                        state.status == LocationsListStatus.renameFailure ||
                        state.status ==
                            LocationsListStatus.locationAddFailure ||
                        state.status ==
                            LocationsListStatus.locationExistsFailure) {
                      return Text(state.status.toString());
                    } else if (state.locations.isEmpty) {
                      return const Text('There is no locations saved');
                    } else {
                      final locations = state.locations;
                      return ListView.builder(
                        itemCount: locations.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            locations[index].pointName,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                              'lat: ${locations[index].latitude}, lon: ${locations[index].longitude}, created: ${locations[index].creationTime}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_forever_rounded),
                            onPressed: () {
                              context
                                  .read<LocationsListCubit>()
                                  .onDeleteLocation(
                                      pointName: locations[index].pointName);
                            },
                          ),
                          onTap: null,
                        ),
                      );
                    }
                  })),
                ),
              );
  }
}