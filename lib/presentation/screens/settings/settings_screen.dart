import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_options.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const ThemeOption(),
              WakelockOption(state: state),
              LocationOption(state: state),
              CompassOption(state: state),
              const ExtraOptions(),
            ],
          );
        }),
      ),
    );
  }
}
