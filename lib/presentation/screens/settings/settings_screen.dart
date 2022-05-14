import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_options.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: context.watch<SettingsCubit>().state.isDarkTheme
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor)
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ThemeSwitch(state: state),
                WakelockSwitch(state: state),
                LocationServiceSwitch(state: state),
                if (!Platform.isIOS) HasCompassSwitch(state: state),
                const ExtraOptions(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
