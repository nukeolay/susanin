abstract class Routes {
  static const splash = SusaninRoute(
    path: '/splash',
    name: 'splash',
  );

  static const tutorial = SusaninRoute(
    path: '/tutorial',
    name: 'tutorial',
  );

  static const home = SusaninRoute(
    path: '/home',
    name: 'home',
  );

  static const settings = SusaninRoute(
    path: 'settings',
    name: 'settings',
  );

  static const detailedLocationInfo = SusaninRoute(
    path: 'detailed_location_info/:id',
    name: 'detailed_location_info',
  );

  static const noCompass = SusaninRoute(
    path: 'no_compass_screen',
    name: 'no_compass_screen',
  );
}

class SusaninRoute {
  const SusaninRoute({required this.name, required this.path});
  final String name;
  final String path;
}
