import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  var currentTheme = ThemeMode.light;

  void setTheme(bool isOn) {
    ThemeMode themeMode = ThemeMode.light;
    currentTheme = themeMode;
    currentTheme = isOn == true ? ThemeMode.dark : ThemeMode.light;
    print('Bool is $isOn');
    print('Current is $currentTheme');
    notifyListeners();
  }
}
