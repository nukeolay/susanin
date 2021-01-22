import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blueGrey[600],
      accentColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.blueGrey[600],
      secondaryHeaderColor: Colors.white,
      fontFamily: 'Montserrat',
      cardColor: Colors.white,
      cardTheme: CardTheme(
        elevation: 2,
        color: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.blueGrey[50],
      accentColor: Colors.purple,
      scaffoldBackgroundColor: Colors.grey[900],
      primaryColorLight: Colors.blueGrey[50],
      primaryColorDark: Colors.grey[600],
      secondaryHeaderColor: Colors.white,
      fontFamily: 'Montserrat',
      cardColor: Colors.grey[800],
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 1,
        color: Colors.grey[700],
      ),
    );
  }
}
