import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/compass_accuracy/compass_accuracy_bloc.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_events.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/screens/home_screen.dart';
import 'package:susanin/presentation/screens/waiting_screen.dart';
import 'package:susanin/presentation/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'domain/bloc/compass_accuracy/compass_accuracy_events.dart';
import 'domain/bloc/fab/fab_bloc.dart';
import 'domain/bloc/location/location_bloc.dart';
import 'domain/bloc/main_pointer/main_pointer_bloc.dart';
import 'domain/bloc/theme/theme_bloc.dart';
import 'domain/bloc/theme/theme_events.dart';
import 'domain/bloc/theme/theme_states.dart';
import 'generated/l10n.dart';

void main() async {
  //todo сделал main async, посмотреть на что влияет
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

class Susanin extends StatelessWidget {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  Stream<CompassEvent> compassStream = FlutterCompass.events;
  Stream<Position> positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(susaninRepository)),
        BlocProvider<FabBloc>(create: (context) => FabBloc(susaninRepository)),
        BlocProvider<LocationBloc>(create: (context) => LocationBloc(susaninRepository)),
        BlocProvider<MainPointerBloc>(create: (context) => MainPointerBloc(susaninRepository, compassStream, positionStream)..add(MainPointerEventGetServices())),
        BlocProvider<CompassAccuracyBloc>(
            create: (context) => CompassAccuracyBloc(compassStream, positionStream)..add(CompassAccuracyEventGetServices())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          print("themeState: ${themeState}");
          final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
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
          } else if (themeState is ThemeStateLoaded) {
            print("themeStateLoaded mode: ${themeState.themeMode}");
            return MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: CustomTheme.lightTheme,
              darkTheme: CustomTheme.darkTheme,
              themeMode: themeState.themeMode,
              title: "Susanin",
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
              // HomeScreen(),
            );
          } else {
            print("themeState -=($themeState)=-");
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
