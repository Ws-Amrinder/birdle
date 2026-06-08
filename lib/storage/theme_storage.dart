import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String> getTheme() async {
  final prefs = await SharedPreferencesAsync();
  return await prefs.getString('theme') ?? 'light';
}

final currentTheme = FutureProvider<String>((ref) async {
  return getTheme();
});

Future<bool> isDarkMode() async {
  final prefs = await SharedPreferencesAsync();
  final theme = await prefs.getString('theme') ?? 'light';
  return theme == 'dark';
}

Future<void> setTheme(String theme) async {
  final prefs = await SharedPreferencesAsync();
  await prefs.setString('theme', theme);
}

final setCurrentTheme = FutureProvider.family<void, String>((
  ref,
  String theme,
) async {
  final prefs = await SharedPreferencesAsync();
  await prefs.getString('theme') ?? 'light';
});
