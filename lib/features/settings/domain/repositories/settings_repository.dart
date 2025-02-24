import 'package:rxdart/rxdart.dart';
import '../entities/settings.dart';

abstract class SettingsRepository {
  const SettingsRepository();

  ValueStream<SettingsEntity> get settingsStream;
  Future<void> update(SettingsEntity settings);
  Future<ThemeMode> setTheme(ThemeMode mode);
}
