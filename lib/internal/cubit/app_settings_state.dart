part of 'app_settings_cubit.dart';

sealed class AppSettingsState extends Equatable {
  const AppSettingsState();
}

class AppSettingsInitialState extends AppSettingsState {
  const AppSettingsInitialState();

  @override
  List<Object?> get props => const [];
}

class AppSettingsLoadedState extends AppSettingsState {
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
