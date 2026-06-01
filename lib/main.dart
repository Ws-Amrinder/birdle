import 'package:birdle/screens/splash.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
import 'providers/taskProvider.dart';

void main() {
  // run app takes a widget and runs it. so MainApp is the root widget here.
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskNotifier(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //
      // title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF5F3EE)),
      // home: Scaffold(
      //   body: Padding(
      //     padding: EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 30),
      //     child: Center(child: HomeScreen()),
      //   ),
      // ),
      home: SplashScreen(),
    );
  }
}
