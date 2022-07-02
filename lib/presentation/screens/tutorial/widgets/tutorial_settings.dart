import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';
import 'package:susanin/presentation/screens/settings/widgets/ios_compass_settings.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_switch.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/tutorial_text.dart';

class TutorialSettings extends StatelessWidget {
  const TutorialSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingsCubit>().state;
    final isServiceDisabled =
        state.locationSettingsStatus == LocationSettingsStatus.disabled;
    return isServiceDisabled
        ? const ServiceDisabledInfo()
        : const ServicePermissionInfo();
  }
}

class ServiceDisabledInfo extends StatelessWidget {
  const ServiceDisabledInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TutorialText(
          'tutorial_settings_disabled'.tr(),
          isErrorText: true,
        ),
        const SizedBox(height: 30),
        Center(
          child: CircularProgressIndicator(color: Theme.of(context).errorColor),
        )
      ],
    );
  }
}

class ServicePermissionInfo extends StatelessWidget {
  const ServicePermissionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingsCubit>().state;
    final isAccessGranted =
        state.locationSettingsStatus == LocationSettingsStatus.granted;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isAccessGranted)
          TutorialText(
            'tutorial_settings_permission'.tr(),
            isErrorText: true,
          ),
        const SizedBox(height: 10),
        LocationServiceSwitch(state: state),
        ThemeSwitch(state: state),
        if (!Platform.isIOS &&
            state.compassSettingsStatus == CompassSettingsStatus.failure)
          TutorialText(
            'tutorial_settings_no_compass'.tr(),
            isErrorText: true,
          ),
        if (Platform.isIOS) const IosCompassSettings(),
      ],
    );
  }
}
