import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/presentation/common/widgets/ios_compass_settings.dart';
import 'package:susanin/presentation/settings/cubit/settings_cubit.dart';
import 'package:susanin/presentation/settings/view/widgets/settings_button.dart';
import 'package:susanin/presentation/common/widgets/settings_switch.dart';
import 'package:susanin/presentation/settings/view/widgets/settings_switches.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.select<AppSettingsCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          // TODO remove AnnotatedRegion
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: // android status bar
              isDarkTheme ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDarkTheme
              ? Brightness.dark // ios status bar
              : Brightness.light,
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        // TODO remove AnnotatedRegion
        value: isDarkTheme
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor,
              ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ThemeSwitch(
                    isDarkTheme: isDarkTheme,
                    action: (_) =>
                        context.read<AppSettingsCubit>().toggleTheme(),
                  ),
                  WakelockSwitch(
                    switchValue: state.isScreenAlwaysOn,
                    action: (_) =>
                        context.read<SettingsCubit>().toggleWakelock(),
                  ),
                  LocationServiceSwitch(
                    locationStatus: state.locationServiceStatus,
                    action: (_) =>
                        context.read<SettingsCubit>().getPermission(),
                  ),
                  if (!Platform.isIOS) HasCompassSwitch(state: state),
                  SettingsButton(
                    text: 'button_instruction'.tr(),
                    action: () {
                      HapticFeedback.heavyImpact();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.tutorial,
                        (route) => false,
                      );
                    },
                  ),
                  if (Platform.isIOS) const IosCompassSettings(),
                  // SettingsButton(
                  //     text: 'Поставить оценку приложению',
                  //     action: () {}), // ! TODO add link
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
