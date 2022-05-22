import 'dart:io';

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

    return Column(
      children: [
        const TutorialText(
            'Для корректной работы приложения необходимо выдайте разрешение на определение геолокации.'),
        const SizedBox(height: 10),
        LocationServiceSwitch(state: state),
        ThemeSwitch(state: state),
        if (!Platform.isIOS &&
            state.compassSettingsStatus == CompassSettingsStatus.failure)
          const TutorialText(
            'К сожалению приложению не далось получить доступ к компасу, поэтому Сусанин не сможет указывать направление к цели, а будет показывать только расстояние до нее.',
            isErrorText: true,
          ),
      ],
    );
  }
}
