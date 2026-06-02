import 'package:flutter/material.dart';

// This provider handles switching between dark and light mode.
// We store isDarkMode as a bool and call notifyListeners() to update the UI.
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  // Getter so other widgets can read the current theme
  bool get isDarkMode => _isDarkMode;

  // Call this to flip the theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
