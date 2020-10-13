import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susanin/models/gps_permission_stream.dart';
import 'package:susanin/widgets/startup_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.green,
    systemNavigationBarColor: Colors.green,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]) // this forces the app to keep portrait orientation- No Matter What
      .then((_) {
    runApp(Susanin());
  });
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
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green,
      ),
      title: "Susanin",
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          StreamProvider<PermissionGPS>.value(
              value: getPermissionGPS(), initialData: PermissionGPS.on),
          StreamProvider<StatusGPS>.value(
              value: getStatusGPS(), initialData: StatusGPS.on),
        ],
        child: StartUp(),
      ),
    );
  }
}
