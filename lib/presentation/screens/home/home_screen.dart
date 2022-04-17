import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: BlocBuilder<MainPointerCubit, MainPointerState>(
                builder: (context, state) {
                  if (state is MainPointerLoaded) {
                    final result =
                        '${state.position!.longitude}\n${state.position!.latitude}\ncompass:${state.compass!.north}';
                    return _onScreenText(result);
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
            ),
          ],
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
