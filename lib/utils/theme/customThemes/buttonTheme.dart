import 'package:birdle/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TButtonTheme {
  TButtonTheme._();

  // Primary button style
  static ButtonStyle primaryElevatedButton(String theme) =>
      ElevatedButton.styleFrom(backgroundColor: TColors.primary(theme));

  // Secondary button style
  static ButtonStyle secondaryElevatedButton(String theme) =>
      ElevatedButton.styleFrom(
        backgroundColor: TColors.grey300,
        foregroundColor: TColors.primary(theme),
      );

  // Disabled button style
  static ButtonStyle disabledElevatedButton(String theme) =>
      ElevatedButton.styleFrom(
        backgroundColor: TColors.grey400,
        foregroundColor: TColors.grey200,
      );

  // Apply globally for ElevatedButton
  static ElevatedButtonThemeData elevatedButtonTheme(String theme) =>
      ElevatedButtonThemeData(style: primaryElevatedButton(theme));

  // Similarly, you can define TextButton and OutlinedButton if needed

  static ButtonStyle primaryTextButton(String theme) => TextButton.styleFrom(
    backgroundColor: TColors.primary(theme),
    foregroundColor: TColors.white(theme),
  );

  static ButtonStyle secondaryTextButton(String theme) => TextButton.styleFrom(
    backgroundColor: TColors.white(theme),
    side: BorderSide(color: TColors.primary(theme)),
  );

  static ButtonStyle transparentTextButton(String theme) =>
      TextButton.styleFrom(backgroundColor: TColors.transparent);

  // Apply globally for ElevatedButton
  static TextButtonThemeData textButtonTheme(String theme) =>
      TextButtonThemeData(style: primaryTextButton(theme));
}
