import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';

class SettingsSwitch extends StatelessWidget {
  final String text;
  final bool switchValue;
  final Function(bool)? action;
  final bool isLoading;
  const SettingsSwitch({
    Key? key,
    required this.text,
    required this.switchValue,
    required this.action,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: Theme.of(context).disabledColor,
              highlightColor: Theme.of(context).colorScheme.inversePrimary,
              child: SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(text),
                  value: false,
                  onChanged: null),
            )
          : SwitchListTile.adaptive(
              activeColor: Theme.of(context).primaryColor,
              contentPadding: const EdgeInsets.all(0),
              title: Text(text),
              value: switchValue,
              onChanged: action),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  final SettingsState state;
  const ThemeSwitch({Key? key, required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SettingsSwitch(
      text: 'Темная тема',
      switchValue: state.isDarkTheme,
      action: (_) => context.read<SettingsCubit>().toggleTheme(),
    );
  }
}

class WakelockSwitch extends StatelessWidget {
  final SettingsState state;
  const WakelockSwitch({Key? key, required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SettingsSwitch(
      text: 'Экран всегда включен',
      switchValue: state.isScreenAlwaysOn,
      action: (_) => context.read<SettingsCubit>().toggleWakelock(),
    );
  }
}

class LocationServiceSwitch extends StatelessWidget {
  final SettingsState state;
  const LocationServiceSwitch({Key? key, required this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isAccessGranted =
        state.locationSettingsStatus == LocationSettingsStatus.granted;
    return SettingsSwitch(
      isLoading: state.locationSettingsStatus == LocationSettingsStatus.loading,
      text: 'Доступ к геолокации',
      switchValue: isAccessGranted,
      action: isAccessGranted
          ? null
          : (_) async => await context.read<SettingsCubit>().getPermission(),
    );
  }
}

class HasCompassSwitch extends StatelessWidget {
  final SettingsState state;
  const HasCompassSwitch({Key? key, required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hasCompass =
        state.compassSettingsStatus == CompassSettingsStatus.success;
    return SettingsSwitch(
      isLoading: state.compassSettingsStatus == CompassSettingsStatus.loading,
      text: 'Наличие компаса в устройстве',
      switchValue: hasCompass,
      action: null,
    );
  }
}
