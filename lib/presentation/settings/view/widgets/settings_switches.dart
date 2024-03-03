import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:susanin/presentation/common/widgets/settings_switch.dart';
import 'package:susanin/presentation/settings/cubit/settings_cubit.dart';

class HasCompassSwitch extends StatelessWidget {
  const HasCompassSwitch({required this.state, super.key});
  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    final hasCompass = state.compassStatus.isSuccess;
    return SettingsSwitch(
      isLoading: state.compassStatus.isLoading,
      text: 'has_compass'.tr(),
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
      text: 'always_on_display'.tr(),
      switchValue: switchValue,
      action: action,
    );
  }
}
