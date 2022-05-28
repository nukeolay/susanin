import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/settings/widgets/ios_compass_settings.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_button.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingsCubit>().state;
    final isDarkTheme = state.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: // android status bar
              isDarkTheme ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDarkTheme
              ? Brightness.dark // ios status bar
              : Brightness.light,
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: isDarkTheme
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor)
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ThemeSwitch(state: state),
              WakelockSwitch(state: state),
              LocationServiceSwitch(state: state),
              if (!Platform.isIOS) HasCompassSwitch(state: state),
              // if (!Platform.isIOS)
              SettingsButton(
                  text: 'button_instruction'.tr(),
                  action: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.tutorial, (route) => false);
                  }),
              const IosCompassSettings(),

              // SettingsButton(
              //     text: 'Поставить оценку приложению',
              //     action: () {}), // ! TODO add link
            ],
          ),
        ),
      ),
    );
  }
}
