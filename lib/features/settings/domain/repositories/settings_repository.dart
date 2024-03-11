import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  const SettingsRepository();

  ValueStream<SettingsEntity> get settingsStream;
  Future<void> update(SettingsEntity settings);
  Future<ThemeMode> setTheme(ThemeMode mode);
}
