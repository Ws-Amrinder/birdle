import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<String> getTheme() async {
  final prefs = await SharedPreferencesAsync();
  final theme = await prefs.getString('theme') ?? 'light';
  return theme;
}

Future<bool> isDarkMode() async {
  final theme = await getTheme();
  return theme == 'dark';
}

Future<void> setTheme(String theme) async {
  final prefs = await SharedPreferencesAsync();
  await prefs.setString('theme', theme);

}