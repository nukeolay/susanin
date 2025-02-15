import 'package:flutter/material.dart';
import 'package:susanin/core/routes/custom_route.dart';

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.green,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.green,
    surface: ThemeData.dark().scaffoldBackgroundColor,
    secondary: Colors.white,
    inversePrimary: Colors.white,
    error: Colors.red,
  ),
  iconTheme: const IconThemeData(
    color: Colors.grey,
    size: 30,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    disabledElevation: 0,
    backgroundColor: Colors.green,
  ),
  disabledColor: Colors.grey,
  hintColor: Colors.white,
  listTileTheme: const ListTileThemeData(
    selectedColor: Colors.green,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ),
);
