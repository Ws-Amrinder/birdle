import 'package:flutter/material.dart';

class TColors {
  TColors._();

  // Core app palette (project literals)
  static Color primary(String theme) => theme == 'dark' ? primaryDark : primaryLight;
  static Color background(String theme) => theme == 'dark' ? backgroundDark : backgroundLight;
  static Color white(String theme) => theme == 'dark' ? whiteDark : whiteLight;
  static Color black(String theme) => theme == 'dark' ? blackDark : blackLight;
  static Color text(String theme) => theme == 'dark' ? textDark : textLight;
  static Color textSecondary(String theme) => theme == 'dark' ? textSecondaryDark : textSecondaryLight;
  static Color border(String theme) => theme == 'dark' ? borderDark : borderLight;
  static Color lightBorder(String theme) => theme == 'dark' ? lightBorderDark : lightBorderLight;
  static Color progressTrack(String theme) => theme == 'dark' ? progressTrackDark : progressTrackLight;

    // Core app palette (project literals)
  static const Color primaryLight =  Color(0xFF2C2C2A);
  static const Color backgroundLight = Color(0xFFF5F3EE);
  static const Color whiteLight = Color(0xFFFFFFFF);
  static const Color blackLight = Color(0xFF000000);
  static const Color textLight = Color(0xFF2C2C2A);
  static const Color textSecondaryLight = Color(0xFF888780);
  static const Color borderLight = Color(0xFFD3D1C7);
  static const Color lightBorderLight = Color(0xFFD3D3D3);
  static const Color progressTrackLight = Color(0x94D3D1C7);

    // Dark Mode
  static const Color primaryDark = Color(0xFFE5E5E5);
  static const Color backgroundDark = Color(0xFF1C1C1C);
  static const Color whiteDark = Color(0xFF000000);
  static const Color blackDark = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color borderDark = Color(0xFF555555);
  static const Color lightBorderDark = Color(0xFF444444);
  static const Color progressTrackDark = Color(0x94555555);

  // Status and semantic colors used across screens/components
  static const Color success = Color(0xFF3B6D11);
  static const Color warning = Color(0xFFEEA538);
  static const Color danger = Color(0xFFD85A30);

  // Material named colors used in the project
  static const Color transparent = Colors.transparent;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color blue = Colors.blue;
  static const Color pink = Colors.pink;
  static const Color purple = Colors.purple;
  static const Color grey = Colors.grey;

  // Grey shades currently referenced
  static final Color grey200 = Colors.grey[200]!;
  static final Color grey300 = Colors.grey[300]!;
  static final Color grey400 = Colors.grey[400]!;

  static final Color green200 = Colors.green[100]!;

}