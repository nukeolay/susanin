import 'package:flutter/material.dart';

abstract class ThemeState {}

class ThemeStateInit extends ThemeState {}

class ThemeStateShowInstruction extends ThemeState {}

class ThemeStateLoaded extends ThemeState {
  ThemeMode themeMode;

  ThemeStateLoaded({this.themeMode});
}
