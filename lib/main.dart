import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/screens/home_screen.dart';
import 'package:susanin/presentation/screens/waiting_screen.dart';
import 'package:susanin/test_screen.dart';
import 'package:susanin/presentation/theme/config.dart';
import 'package:susanin/presentation/theme/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'domain/bloc/compass/compass_bloc.dart';
import 'domain/bloc/data/data_bloc.dart';
import 'domain/bloc/data/data_events.dart';
import 'domain/bloc/data/data_states.dart';
import 'domain/bloc/location/location_bloc.dart';
import 'domain/bloc/location/location_events.dart';
import 'domain/bloc/location/location_states.dart';
import 'generated/l10n.dart';

void main() async {
  //сделал main async
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
  //FlutterCompass flutterCompass = FlutterCompass;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider<DataBloc>(create: (context) => DataBloc(susaninRepository)),
        BlocProvider<LocationBloc>(create: (context) => LocationBloc(susaninRepository)),
        BlocProvider<MyCompassBloc>(create: (context) => MyCompassBloc(compassStream)),
      ],
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          //final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
          final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
          if (state is LocationStateDataLoading) {
            locationBloc.add(LocationEventGetData());
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
          } else if (state is LocationStateDataLoaded) {
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
              themeMode: currentTheme.currentTheme,
              title: "Susanin",
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
              // HomeScreen(),
            );
          } else {
            print("state -=($state)=-");
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
