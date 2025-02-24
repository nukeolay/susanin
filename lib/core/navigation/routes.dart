abstract class Routes {
  static const splash = '/splash';

  static const tutorial = '/tutorial';

  static const home = '/';

  static const settings = '/$settingsRelative';
  static const settingsRelative = 'settings';

  static String location(String id) => '/$locationRelative/$id';
  static const locationRelative = 'detailed_location_info';

  static const noCompass = '/$noCompassRelative';
  static const noCompassRelative = 'no_compass_screen';
}
