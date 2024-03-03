import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/settings/domain/use_cases/toggle_theme.dart';
import 'package:susanin/internal/repository_initializer.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/core/theme/dark_theme.dart';
import 'package:susanin/core/theme/light_theme.dart';
import 'package:susanin/presentation/home/home_screen.dart';
import 'package:susanin/presentation/tutorial/tutorial_screen.dart';

class SusaninApp extends StatefulWidget {
  const SusaninApp({super.key});

  @override
  State<SusaninApp> createState() => _SusaninAppState();
}

class _SusaninAppState extends State<SusaninApp> {
  bool _isLoading = true;
  final _repositoryInitializer = RepositoryInitializer();

  @override
  void initState() {
    _repositoryInitializer
        .init()
        .then((_) => setState(() => _isLoading = false));
    super.initState();
  }

  @override
  void dispose() {
    _repositoryInitializer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          // TODO impl SplashScreen
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _repositoryInitializer.compassRepository,
        ),
        RepositoryProvider.value(
          value: _repositoryInitializer.locationRepository,
        ),
        RepositoryProvider.value(
          value: _repositoryInitializer.placesRepository,
        ),
        RepositoryProvider.value(
          value: _repositoryInitializer.settingsRepository,
        ),
        RepositoryProvider.value(
          value: _repositoryInitializer.wakelockRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) => AppSettingsCubit(
          settingsRepository: _repositoryInitializer.settingsRepository,
          toggleTheme: ToggleTheme(
            _repositoryInitializer.settingsRepository,
          ),
        ),
        child: const _App(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Susanin',
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: darkTheme,
          theme: lightTheme,
          home: state.isFirstTime ? const TutorialScreen() : const HomeScreen(),
          onGenerateRoute: Routes.onGenerateRoute,
        );
      },
    );
  }
}
