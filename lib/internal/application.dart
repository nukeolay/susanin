import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/navigation/router.dart';
import '../core/navigation/routes.dart';
import '../core/theme/dark_theme.dart';
import '../core/theme/light_theme.dart';
import 'cubit/app_settings_cubit.dart';
import '../generated/l10n.dart';

class SusaninApp extends StatefulWidget {
  const SusaninApp();

  @override
  State<SusaninApp> createState() => _SusaninAppState();
}

class _SusaninAppState extends State<SusaninApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter();
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppSettingsCubit, AppSettingsState>(
      listenWhen: (previous, current) {
        return previous is AppSettingsInitialState &&
            current is AppSettingsLoadedState;
      },
      listener: (context, state) {
        if (state is! AppSettingsLoadedState) {
          return;
        }
        _uiSetup(state.isDarkTheme);
        _router.go(
          state.isFirstTime ? Routes.tutorial : Routes.home,
        );
      },
      builder: (context, state) {
        final isDark = state is AppSettingsLoadedState && state.isDarkTheme;
        return MaterialApp.router(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Susanin',
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: darkTheme,
          theme: lightTheme,
          routerConfig: _router,
        );
      },
    );
  }
}
