import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SusaninApp extends StatelessWidget {
  const SusaninApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Susanin',
      // theme: ThemeData(
      //   primarySwatch: Colors.grey,
      //   scaffoldBackgroundColor: appTheme.background,
      //   fontFamily: 'Montserrat',
      //   pageTransitionsTheme: const PageTransitionsTheme(builders: {
      //     TargetPlatform.android: CustomPageTransitionBuilder(),
      //     TargetPlatform.iOS: CustomPageTransitionBuilder(),
      //   }),
      //   textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //       textStyle: MaterialStateProperty.all(
      //         TextStyle(color: appTheme.buttonTextColor),
      //       ),
      //     ),
      //   ),
      //   textTheme: TextTheme(
      //     button: TextStyle(
      //       color: appTheme.buttonTextColor,
      //     ),
      //     bodyText2: TextStyle(
      //       color: appTheme.buttonTextColor,
      //     ),
      //   ),
      // ),
      // home: const HomeScreen(),
      // onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
