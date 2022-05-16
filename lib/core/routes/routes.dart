import 'package:flutter/material.dart';
import 'package:susanin/presentation/screens/detailed_location_info/detailed_location_info_screen.dart';
import 'package:susanin/presentation/screens/home/home_screen.dart';
import 'package:susanin/presentation/screens/no_compass/no_compass_screen.dart';
import 'package:susanin/presentation/screens/settings/settings_screen.dart';
import 'package:susanin/presentation/screens/tutorial/tutorial_screen.dart';

class Routes {
  static const home = '/home-screen';
  static const tutorial = '/tutorial-screen';
  static const settings = '/settings-screen';
  static const detailedLocationInfo = '/detailed-location-info-screen';
  static const noCompass = '/no-compass-screen';

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
          case detailedLocationInfo:
            return const DetailedLocationInfoScreen();
          case noCompass:
            return const NoCompassScreen();
          default:
            return const HomeScreen();
        }
      },
    );
  }
}
