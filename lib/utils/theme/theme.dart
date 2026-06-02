import 'package:birdle/utils/constants/colors.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:birdle/utils/theme/customThemes/textTheme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static _fieldBorderRadius(String theme) =>
      BorderRadius.all(Radius.circular(12));
  static const _fieldBorderColor = TColors.border;

  static _enabledBorder(String theme) => OutlineInputBorder(
    borderRadius: _fieldBorderRadius(theme),
    borderSide: BorderSide(color: _fieldBorderColor(theme), width: 1),
  );

  static _focusedBorder(String theme) => OutlineInputBorder(
    borderRadius: _fieldBorderRadius(theme),
    borderSide: BorderSide(color: _fieldBorderColor(theme), width: 2),
  );

  static _errorBorder(String theme) => OutlineInputBorder(
    borderRadius: _fieldBorderRadius(theme),
    borderSide: BorderSide(color: TColors.danger, width: 1),
  );

  static InputDecorationTheme _inputDecorationTheme(String theme) =>
      InputDecorationTheme(
        filled: true,
        fillColor: TColors.white(theme),
        border: _enabledBorder(theme),
        enabledBorder: _enabledBorder(theme),
        focusedBorder: _focusedBorder(theme),
        errorBorder: _errorBorder(theme),
        focusedErrorBorder: _focusedBorder(theme),
      );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: TColors.background("light"),
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: TColors.primary("light"),
    textTheme: TTextTheme.lightTextTheme,
    inputDecorationTheme: _inputDecorationTheme("light"),
    textButtonTheme: TButtonTheme.textButtonTheme("light"),
    elevatedButtonTheme: TButtonTheme.elevatedButtonTheme("light"),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: TColors.backgroundDark,
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: TColors.primary("dark"),
    textTheme: TTextTheme.darkTextTheme,
    inputDecorationTheme: _inputDecorationTheme("dark"),
    textButtonTheme: TButtonTheme.textButtonTheme("dark"),
    elevatedButtonTheme: TButtonTheme.elevatedButtonTheme("dark"),
  );
}
