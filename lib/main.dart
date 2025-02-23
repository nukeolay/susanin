import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/internal/di_provider.dart';
import 'package:susanin/internal/application.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/presentation/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DiProvider(
      child: BlocProvider(
        create: (context) => AppSettingsCubit(
          settingsRepository: context.read<SettingsRepository>(),
        )..init(),
        child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
          builder: (context, state) {
            switch (state) {
              case AppSettingsInitialState():
                return const Directionality(
                  textDirection: TextDirection.ltr,
                  child: SplashScreen(),
                );
              case AppSettingsLoadedState():
                _uiSetup(state.isDarkTheme);
                return const SusaninApp();
            }
          },
        ),
      ),
    ),
  );
}

Future<void> _uiSetup(bool isDarkTheme) async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          isDarkTheme ? Brightness.light : Brightness.dark, // Android opt
      statusBarBrightness:
          isDarkTheme ? Brightness.light : Brightness.dark, // iOS opt
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          isDarkTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
