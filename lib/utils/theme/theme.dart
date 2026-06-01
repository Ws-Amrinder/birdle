import 'package:birdle/utils/theme/customThemes/textTheme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();



  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF5F3EE),
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    textTheme: TTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData();

}


