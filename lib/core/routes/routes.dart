import 'package:flutter/material.dart';

import 'package:susanin/presentation/home/home_screen.dart';
import 'package:susanin/presentation/settings/settings_screen.dart';
import 'package:susanin/presentation/tutorial/tutorial_screen.dart';

class Routes {
  static const String home = '/home-screen';
  static const String tutorial = '/tutorial-screen';
  static const String settings = '/settings-screen';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) {
        switch (routeSettings.name) {
          case home:
            return const HomeScreen();
          case tutorial:
            return const TutorialScreen();
          case settings:
            return const SettingsScreen();
          default:
            return const HomeScreen();
        }
      },
    );
  }
}
