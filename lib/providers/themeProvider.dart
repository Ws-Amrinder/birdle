import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  String theme = "light";

  void setTheme(String theme) {
    this.theme = theme;
    notifyListeners();
  }

  String getTheme() {
    return theme;
  }
}
