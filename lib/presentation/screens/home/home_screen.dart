import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/usecases/load_locations.dart';
import 'package:susanin/domain/location_points/usecases/save_locations.dart';
import 'package:susanin/internal/service_locator.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    serviceLocator<SaveLocations>()([
      LocationPointEntity(
        latitude: 1,
        longitude: 2,
        pointName: 'pointName 1',
        creationTime: DateTime.now(),
      ),
      LocationPointEntity(
        latitude: 3,
        longitude: 4,
        pointName: 'pointName 2',
        creationTime: DateTime.now(),
      ),
    ]);
    serviceLocator<LoadLocations>()();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              BlocBuilder<MainPointerCubit, MainPointerState>(
                builder: (context, state) {
                  if (state is MainPointerLoaded) {
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
                  } else if (state is MainPointerInit) {
                    return _onScreenText('Init');
                  } else if (state is MainPointerLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is MainPointerError) {
                    return Column(
                      children: [
                        Text(
                            'isServiceEnabled: ${state.isServiceEnabled}\nisPermissionGranted: ${state.isPermissionGranted}'),
                        const CircularProgressIndicator(color: Colors.red),
                      ],
                    );
                  } else {
                    return _onScreenText('Unknown');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _onScreenText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 30),
    );
  }
}
