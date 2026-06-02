import 'package:birdle/screens/splash.dart';
import 'package:birdle/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/taskProvider.dart';
import 'providers/themeProvider.dart';

void main() {
  // run app takes a widget and runs it. so MainApp is the root widget here.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskNotifier()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final theme = themeNotifier.getTheme();
    final themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;

    return MaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: themeMode,
      home: SplashScreen(),
    );
  }
}
