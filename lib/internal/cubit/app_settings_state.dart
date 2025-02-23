part of 'app_settings_cubit.dart';

sealed class AppSettingsState {
  const AppSettingsState();
}

class AppSettingsInitialState implements AppSettingsState {
  const AppSettingsInitialState();
}

class AppSettingsLoadedState extends Equatable implements AppSettingsState {
  const AppSettingsLoadedState({
    required this.isFirstTime,
    required this.themeMode,
  });

  final bool isFirstTime;
  final ThemeMode themeMode;

  bool get isDarkTheme => themeMode == ThemeMode.dark;

  AppSettingsLoadedState copyWith({
    bool? isLoading,
    bool? isFirstTime,
    ThemeMode? themeMode,
  }) {
    return AppSettingsLoadedState(
      isFirstTime: isFirstTime ?? this.isFirstTime,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [
        isFirstTime,
        themeMode,
      ];
}
