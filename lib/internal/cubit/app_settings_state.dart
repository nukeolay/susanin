part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  const AppSettingsState({
    required this.isDarkTheme,
    required this.isFirstTime,
    required this.isLoading,
  });

  final bool isLoading;
  final bool isDarkTheme;
  final bool isFirstTime;

  static const initial = AppSettingsState(
    isLoading: true,
    isDarkTheme: false,
    isFirstTime: true,
  );

  AppSettingsState copyWith({
    bool? isLoading,
    bool? isDarkTheme,
    bool? isFirstTime,
  }) {
    return AppSettingsState(
      isLoading: isLoading ?? this.isLoading,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isDarkTheme,
        isFirstTime,
      ];
}
