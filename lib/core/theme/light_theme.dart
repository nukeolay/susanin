import 'package:flutter/material.dart';
import 'package:susanin/core/routes/custom_route.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.green,
  iconTheme: const IconThemeData(
    color: Colors.grey,
    size: 30,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    disabledElevation: 0,
    backgroundColor: Colors.green,
  ),
  cardColor: Colors.grey.shade100,
  disabledColor: Colors.grey,
  hintColor: Colors.white,
  listTileTheme: const ListTileThemeData(
    selectedColor: Colors.green,
  ),
  primaryColorDark: Colors.grey,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ), colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.green,
    background: ThemeData.light().scaffoldBackgroundColor,
    secondary: Colors.green,
    inversePrimary: Colors.white,
  ).copyWith(error: Colors.red),
);
