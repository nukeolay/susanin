import 'package:go_router/go_router.dart';

import 'routes.dart';
import '../../presentation/detailed_info/detailed_location_info_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/no_compass/no_compass_screen.dart';
import '../../presentation/settings/settings_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/tutorial/tutorial_screen.dart';

GoRouter createRouter() => GoRouter(
      initialLocation: Routes.splash,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          path: Routes.tutorial,
          builder: (context, state) {
            return const TutorialScreen();
          },
        ),
        GoRoute(
          path: Routes.home,
          builder: (context, state) {
            return const HomeScreen();
          },
          routes: [
            GoRoute(
              path: Routes.settingsRelative,
              builder: (context, state) {
                return const SettingsScreen();
              },
            ),
            GoRoute(
              path: '${Routes.locationRelative}/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return DetailedInfoScreen(id: id ?? '');
              },
            ),
            GoRoute(
              path: Routes.noCompassRelative,
              builder: (context, state) {
                return const NoCompassScreen();
              },
            ),
          ],
        ),
      ],
    );
