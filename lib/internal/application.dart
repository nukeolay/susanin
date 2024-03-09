import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:susanin/generated/l10n.dart';
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
        )..init(),
        child: const _App(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  Future<void> _uiSetup(bool isDarkTheme) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark, // Android opt
        statusBarBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark, // iOS opt
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        _uiSetup(state.isDarkTheme);
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
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
