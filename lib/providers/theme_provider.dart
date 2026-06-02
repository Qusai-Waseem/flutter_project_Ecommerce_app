import 'package:flutter/material.dart';

//  provider with  theme state  light dark 

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  
  bool get isDarkMode => _isDarkMode;

 
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
