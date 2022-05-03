import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class MainPointer extends StatelessWidget {
  const MainPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPointerCubit, MainPointerState>(
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
              '${state.longitude}\n${state.latitude}\nУгол (рад): ${state.angle.toStringAsFixed(2)}\nТочность (м): ${state.positionAccuracy.toStringAsFixed(2)}';
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: state.angle,
                    child: const Icon(
                      Icons.arrow_circle_up_rounded,
                      size: 150,
                    ),
                  ),
                  CircleAvatar(
                    radius: state.positionAccuracy,
                    backgroundColor: Colors.red.withOpacity(0.3),
                  ),
                ],
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
      style: const TextStyle(fontSize: 20),
    );
  }
}
