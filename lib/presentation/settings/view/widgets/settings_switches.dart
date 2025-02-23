import 'package:flutter/material.dart';

import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/presentation/common/settings_switch.dart';
import 'package:susanin/presentation/settings/cubit/settings_cubit.dart';

class HasCompassSwitch extends StatelessWidget {
  const HasCompassSwitch({required this.state, super.key});
  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    final hasCompass = state.compassStatus.isSuccess;
    return SettingsSwitch(
      isLoading: state.compassStatus.isLoading,
      text: context.s.has_compass,
      switchValue: hasCompass,
      action: null,
    );
  }
}

class WakelockSwitch extends StatelessWidget {
  const WakelockSwitch({
    required this.switchValue,
    required this.action,
    super.key,
  });
  final bool switchValue;
  final Function(bool value)? action;

  @override
  Widget build(BuildContext context) {
    return SettingsSwitch(
      text: context.s.always_on_display,
      switchValue: switchValue,
      action: action,
    );
  }
}
