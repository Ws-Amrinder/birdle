import 'package:birdle/utils/theme/customThemes/textTheme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static const _fieldBorderRadius = BorderRadius.all(Radius.circular(12));
  static const _fieldBorderColor = Color(0xFFD3D1C7);

  static const _enabledBorder = OutlineInputBorder(
    borderRadius: _fieldBorderRadius,
    borderSide: BorderSide(color: _fieldBorderColor, width: 1),
  );

  static const _focusedBorder = OutlineInputBorder(
    borderRadius: _fieldBorderRadius,
    borderSide: BorderSide(color: _fieldBorderColor, width: 2),
  );

  static const _errorBorder = OutlineInputBorder(
    borderRadius: _fieldBorderRadius,
    borderSide: BorderSide(color: Colors.red, width: 1),
  );

  static const InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: _enabledBorder,
    enabledBorder: _enabledBorder,
    focusedBorder: _focusedBorder,
    errorBorder: _errorBorder,
    focusedErrorBorder: _focusedBorder,
  );

  /// Explicit decoration for TextFields — more reliable than applyDefaults with M3.
  static InputDecoration fieldDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: _enabledBorder,
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      errorBorder: _enabledBorder,
      focusedErrorBorder: _focusedBorder,
    );
  }

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF5F3EE),
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    textTheme: TTextTheme.lightTextTheme,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    inputDecorationTheme: _inputDecorationTheme,
  );
}
