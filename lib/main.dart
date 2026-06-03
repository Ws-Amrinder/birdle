import 'package:birdle/screens/splash.dart';
import 'package:birdle/storage/theme_storage.dart';
import 'package:birdle/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // run app takes a widget and runs it. so MainApp is the root widget here.
  runApp(
      ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(currentTheme).value ?? '';

    return MaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: theme == 'light' ? ThemeMode.light : ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
