import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    //notifyListeners();
  }
  void setThemeMode(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    //notifyListeners();
  }

  bool get getIsDarkTheme => _isDarkTheme;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blueGrey[600],
      accentColor: Colors.green,
      scaffoldBackgroundColor: Colors.grey[50],
      primaryColorLight: Colors.grey[50],
      primaryColorDark: Colors.black,
      secondaryHeaderColor: Colors.grey[50],
      fontFamily: 'Montserrat',
      errorColor: Colors.red,
      cardColor: Colors.grey[300],
      cardTheme: CardTheme(
        elevation: 0,
        color: Colors.grey[200],
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.blueGrey[50],
      accentColor: Colors.purple,
      scaffoldBackgroundColor: Colors.grey[900],
      primaryColorLight: Colors.blueGrey[50],
      primaryColorDark: Colors.white,
      secondaryHeaderColor: Colors.white,
      fontFamily: 'Montserrat',
      errorColor: Colors.red[900],
      cardColor: Colors.grey[700],
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: Colors.grey[700],
      ),
    );
  }
}
