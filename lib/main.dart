import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susanin/models/gps_permission_stream.dart';
import 'package:susanin/theme/config.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/screens/home_screen.dart';
import 'package:susanin/theme/custom_theme.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/startup_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    runApp(SusaninApp());
  });
}

class SusaninApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => currentTheme,
        child: Susanin(),
    );
  }
}



class Susanin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      themeMode: context.watch<CustomTheme>().currentTheme,
      title: "Susanin",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // MultiProvider(
      // providers: [
      //   ChangeNotifierProvider<CustomTheme>.value(value: currentTheme),
      // //StreamProvider<PermissionGPS>.value(
      // //           value: getPermissionGPS(), initialData: PermissionGPS.on),
      // //       StreamProvider<StatusGPS>.value(
      // //           value: getStatusGPS(), initialData: StatusGPS.on),
      // ],
      // child: HomeScreen(),
      // ),
    );
  }
}
