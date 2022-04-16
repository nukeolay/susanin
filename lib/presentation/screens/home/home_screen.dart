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
          children: [
            Center(
              child: BlocBuilder<MainPointerCubit, MainPointerState>(
                builder: (context, state) {
                  if (state is MainPointerLoaded) {
                    final coordinates =
                        '${state.position.longitude}\n${state.position.latitude}';
                    return Text(coordinates);
                  } else if (state is MainPointerInit) {
                    return const Text('Init');
                  } else if (state is MainPointerLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is MainPointerError) {
                    return Text(state.message);
                  } else {
                    return const Text('Unknown');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
