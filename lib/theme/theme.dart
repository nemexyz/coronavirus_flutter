import 'package:coronavirus/repository/store_manager.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    primaryColor: ThemeColors.primaryColor,
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    primaryColor: ThemeColors.primaryColor,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = MyThemes.lightTheme;
  ThemeData getTheme() => _themeData;

  ThemeProvider() {
    initializeDateFormatting();
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = MyThemes.lightTheme;
      } else {
        _themeData = MyThemes.darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = MyThemes.darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = MyThemes.lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == MyThemes.darkTheme) {
      setLightMode();
    } else {
      setDarkMode();
    }
  }

  bool isDarkMode() {
    return _themeData == MyThemes.darkTheme;
  }
}
