import 'package:flutter/material.dart';
import 'package:myapp/src/themes/light_mode.dart';
import 'package:myapp/src/themes/dark_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == lightMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
  }

  

}
