import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_state.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<MainPointerCubit, MainPointerState>(
                builder: (context, state) {
                  if (state.status == MainPointerStatus.loading) {
                    return const CircularProgressIndicator();
                  } else if (state.status != MainPointerStatus.loaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CircularProgressIndicator(color: Colors.red),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _onScreenText(
                              'ServiceFailure: ${state.status == MainPointerStatus.serviceFailure}\nPermissionFailure: ${state.status == MainPointerStatus.permissionFailure}\nisCompassError: ${state.isCompassError}\nUnknownFailure: ${state.status == MainPointerStatus.unknownFailure}'),
                        ),
                      ],
                    );
                  } else {
                    final result =
                        '${state.position.longitude}\n${state.position.latitude}\ncompass:${state.compass.north.toStringAsFixed(2)}';
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Transform.rotate(
                          angle: (state.compass.north * (math.pi / 180) * -1),
                          child: const Icon(
                            Icons.arrow_circle_up_rounded,
                            size: 150,
                          ),
                        ),
                        _onScreenText(result),
                      ],
                    );
                  }
                },
              ),
              Expanded(
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
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<AddLocationCubit, AddLocationState>(
          builder: ((context, state) {
            if (state.status == AddLocationStatus.editing) {
              return AlertDialog(
                title: const Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('lat: ${state.latitude}, lon: ${state.longitude}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      context.read<AddLocationCubit>().onSaveLocation(
                            latitude: state.latitude,
                            longitude: state.longitude,
                            pointName: 'name ${DateTime.now()}',
                          );
                    },
                  ),
                ],
              );
            } else if (state.status == AddLocationStatus.loading) {
              return const FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.green,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (state.status == AddLocationStatus.failure) {
              return const FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.grey,
                child: Icon(Icons.not_interested_rounded),
              );
            }
            return GestureDetector(
              onLongPress: () =>
                  context.read<AddLocationCubit>().onAddLongPress(),
              child: FloatingActionButton(
                onPressed: () => context.read<AddLocationCubit>().onAddTap(),
                backgroundColor: Colors.green,
                child: const Icon(Icons.add_location_alt_rounded),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _onScreenText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }
}
