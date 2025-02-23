import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/core/theme/dark_theme.dart';
import 'package:susanin/core/theme/light_theme.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/presentation/home/home_screen.dart';
import 'package:susanin/presentation/tutorial/tutorial_screen.dart';

class SusaninApp extends StatelessWidget {
  const SusaninApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        if (state is! AppSettingsLoadedState) {
          return const SizedBox();
        }
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Susanin',
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: darkTheme,
          theme: lightTheme,
          home: state.isFirstTime ? const TutorialScreen() : const HomeScreen(),
          onGenerateRoute: Routes.onGenerateRoute,
        );
      },
    );
  }
}
