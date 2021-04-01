import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/compass_accuracy/compass_accuracy_bloc.dart';
import 'package:susanin/domain/bloc/compass_accuracy/compass_accuracy_events.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/screens/home_screen.dart';
import 'package:susanin/presentation/screens/on_boarding_screen.dart';
import 'package:susanin/presentation/screens/waiting_screen.dart';
import 'package:susanin/presentation/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'domain/bloc/fab/fab_bloc.dart';
import 'domain/bloc/location_list/location_list_bloc.dart';
import 'domain/bloc/pointer/pointer_bloc.dart';
import 'domain/bloc/pointer/pointer_events.dart';
import 'domain/bloc/theme/theme_bloc.dart';
import 'domain/bloc/theme/theme_events.dart';
import 'domain/bloc/theme/theme_states.dart';
import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.grey[900],
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) // всегда портретная ориентация экрана
      .then((_) {
    runApp(Susanin());
  });
}

class Susanin extends StatefulWidget {
  @override
  _SusaninState createState() => _SusaninState();
}

class _SusaninState extends State<Susanin> with WidgetsBindingObserver {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  Stream<CompassEvent> compassStream = FlutterCompass.events;
  Stream<Position> positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best);
  ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
      //print(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    // SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
    // Stream<CompassEvent> compassStream = FlutterCompass.events;
    // Stream<Position> positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(susaninRepository)),
        BlocProvider<LocationListBloc>(create: (context) => LocationListBloc(susaninRepository)),
        BlocProvider<FabBloc>(create: (context) => FabBloc()),
        BlocProvider<PointerBloc>(create: (context) => PointerBloc()),
        BlocProvider<CompassAccuracyBloc>(create: (context) => CompassAccuracyBloc(compassStream, positionStream)),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final CompassAccuracyBloc compassAccuracyBloc = BlocProvider.of<CompassAccuracyBloc>(context);
          //final PointerBloc pointerBloc = BlocProvider.of<PointerBloc>(context);
          final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
          if (_notification == AppLifecycleState.inactive) {
            compassAccuracyBloc.dispose();
          } else if (_notification == AppLifecycleState.resumed) {
            compassAccuracyBloc.dispose();
            compassAccuracyBloc.add(CompassAccuracyEventCheckPermissionsOnOff());
          }
          if (themeState is ThemeStateInit) {
            themeBloc.add(ThemeEventGetData());
            return MaterialApp(
              title: "Susanin",
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: CustomTheme.lightTheme,
              home: WaitingScreen(),
            );
          } else if (themeState is ThemeStateShowInstruction) {
            return MaterialApp(
              title: "Susanin",
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: CustomTheme.lightTheme,
              home: OnBoardingScreen(),
            );
          } else if (themeState is ThemeStateLoaded) {
            themeMode = themeState.themeMode;
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarIconBrightness: themeState.themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
            ));
            return MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              themeMode: themeMode,
              theme: CustomTheme.lightTheme,
              darkTheme: CustomTheme.darkTheme,
              title: "Susanin",
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
              // HomeScreen(),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
