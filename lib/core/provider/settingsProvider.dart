import 'package:flutter/material.dart';

class settingProvider extends ChangeNotifier {
  ThemeMode currentThemeMode = ThemeMode.light;

  void changeThemeMode(ThemeMode themeMode) {
    currentThemeMode = themeMode;
    notifyListeners();
  }

  bool isDark() => currentThemeMode == ThemeMode.dark;
}
