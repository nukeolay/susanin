import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/custom_pointer.dart';

class MainPointer extends StatelessWidget {
  const MainPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPointerCubit, MainPointerState>(
      builder: (context, state) {
        // print(state);
        if (state.locationServiceStatus == LocationServiceStatus.loading) {
          return const CircularProgressIndicator();
        } else if (state.locationServiceStatus !=
            LocationServiceStatus.loaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(color: Colors.red),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _onScreenText(
                    'ServiceFailure: ${state.locationServiceStatus == LocationServiceStatus.disabled}\nPermissionFailure: ${state.locationServiceStatus == LocationServiceStatus.noPermission}\nisCompassError: ${state.compassStatus == CompassStatus.failure}\nUnknownFailure: ${state.locationServiceStatus == LocationServiceStatus.unknownFailure}'),
              ),
            ],
          );
        } else {
          final result =
              'UserLat: ${state.userLongitude}\nUserLat: ${state.userLatitude}\nУгол (рад): ${state.angle.toStringAsFixed(2)}\nТочность (м): ${state.positionAccuracy.toStringAsFixed(2)}\nPoint id: ${state.activeLocationId}\nName: ${state.pointName}\nPointLat: ${state.pointLatitude}\nPointLon: ${state.pointLongitude}';
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomPointer(
                rotateAngle: state.angle,
                accuracyAngle: state.compassAccuracy + state.positionAccuracy/10,
                pointerSize: 60,
              ),
              _onScreenText(result),
            ],
          );
        }
      },
    );
  }

  Widget _onScreenText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 10),
    );
  }
}
