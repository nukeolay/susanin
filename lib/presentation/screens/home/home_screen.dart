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
    // serviceLocator<SaveLocations>()([
    //   LocationPointEntity(
    //     latitude: 1,
    //     longitude: 2,
    //     pointName: 'pointName 1',
    //     creationTime: DateTime.now(),
    //   ),
    //   LocationPointEntity(
    //     latitude: 3,
    //     longitude: 4,
    //     pointName: 'pointName 2',
    //     creationTime: DateTime.now(),
    //   ),
    // ]);
    // serviceLocator<LoadLocations>()();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<MainPointerCubit, MainPointerState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (state.isCompassError ||
                      !state.isPermissionGranted ||
                      !state.isServiceEnabled ||
                      state.isUnknownError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CircularProgressIndicator(color: Colors.red),
                        _onScreenText(
                            'isServiceEnabled: ${state.isServiceEnabled}\nisPermissionGranted: ${state.isPermissionGranted}\nisCompassError: ${state.isCompassError}\nisUnknownError: ${state.isUnknownError}'),
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
              Container(
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
                      state.status ==
                          LocationsListStatus.locationExistsFailure) {
                    return Text(state.status.toString());
                  } else if (state.locations.isEmpty) {
                    return const Text('There is no locations saved');
                  } else {
                    return Column(
                      children: [
                        ...state.locations.map(
                          (location) => Text(
                            location.pointName,
                          ),
                        ),
                      ],
                    );
                  }
                })),
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<AddLocationCubit, AddLocationState>(
          builder: ((context, state) {
            if (state.status == AddLocationStatus.loading) {
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
                backgroundColor: Colors.red,
                child: Icon(Icons.not_interested_rounded),
              );
            }
            return FloatingActionButton(
              onPressed: () {
                context.read<AddLocationCubit>().onSaveLocation(
                      latitude: 0,
                      longitude: 0,
                      pointName: DateTime.now().toString(),
                    );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_location_alt_rounded),
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
