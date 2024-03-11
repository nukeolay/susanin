part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  const AppSettingsState({
    required this.isFirstTime,
    required this.isLoading,
    required this.themeMode,
  });

  final bool isLoading;
  final bool isFirstTime;
  final ThemeMode themeMode;

  static const initial = AppSettingsState(
    isLoading: true,
    isFirstTime: true,
    themeMode: ThemeMode.light,
  );

  bool get isDarkTheme => themeMode == ThemeMode.dark;

  AppSettingsState copyWith({
    bool? isLoading,
    bool? isFirstTime,
    ThemeMode? themeMode,
  }) {
    return AppSettingsState(
      isLoading: isLoading ?? this.isLoading,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isFirstTime,
        themeMode,
      ];
}
