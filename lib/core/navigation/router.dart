import 'package:go_router/go_router.dart';

import 'package:susanin/core/navigation/routes.dart';
import 'package:susanin/presentation/detailed_info/detailed_location_info_screen.dart';
import 'package:susanin/presentation/home/home_screen.dart';
import 'package:susanin/presentation/no_compass/no_compass_screen.dart';
import 'package:susanin/presentation/settings/settings_screen.dart';
import 'package:susanin/presentation/splash/splash_screen.dart';
import 'package:susanin/presentation/tutorial/tutorial_screen.dart';

GoRouter createRouter() => GoRouter(
      initialLocation: Routes.splash.path,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.splash.path,
          name: Routes.splash.name,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          path: Routes.tutorial.path,
          name: Routes.tutorial.name,
          builder: (context, state) {
            return const TutorialScreen();
          },
        ),
        GoRoute(
          path: Routes.home.path,
          name: Routes.home.name,
          builder: (context, state) {
            return const HomeScreen();
          },
          routes: [
            GoRoute(
              path: Routes.settings.path,
              name: Routes.settings.name,
              builder: (context, state) {
                return const SettingsScreen();
              },
            ),
            GoRoute(
              path: Routes.detailedLocationInfo.path,
              name: Routes.detailedLocationInfo.name,
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return DetailedInfoScreen(id: id ?? '');
              },
            ),
            GoRoute(
              path: Routes.noCompass.path,
              name: Routes.noCompass.name,
              builder: (context, state) {
                return const NoCompassScreen();
              },
            ),
          ],
        ),
      ],
    );
