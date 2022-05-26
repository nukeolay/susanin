import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_switch.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/tutorial_text.dart';

class TutorialSettings extends StatelessWidget {
  const TutorialSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingsCubit>().state;
    final isAccessGranted =
        state.locationSettingsStatus == LocationSettingsStatus.granted;
    return Column(
      children: [
        if (!isAccessGranted) TutorialText('tutorial_settings_permission'.tr()),
        const SizedBox(height: 10),
        LocationServiceSwitch(state: state),
        ThemeSwitch(state: state),
        if (!Platform.isIOS &&
            state.compassSettingsStatus == CompassSettingsStatus.failure)
          TutorialText(
            'tutorial_settings_no_compass'.tr(),
            isErrorText: true,
          ),
      ],
    );
  }
}
