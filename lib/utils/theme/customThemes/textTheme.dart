import 'package:birdle/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 24, color: TColors.text("light")),
    headlineMedium: TextStyle(fontSize: 20, color: TColors.text("light")),
    bodyMedium: TextStyle(fontSize: 16, color: TColors.textSecondary("light")),
    bodySmall: TextStyle(fontSize: 11, color: TColors.textSecondary("light")),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 24, color: TColors.text("dark")),
    headlineMedium: TextStyle(fontSize: 20, color: TColors.text("dark")),
    bodyMedium: TextStyle(fontSize: 16, color: TColors.textSecondary("dark")),
    bodySmall: TextStyle(fontSize: 11, color: TColors.textSecondary("dark")),
  );
}
