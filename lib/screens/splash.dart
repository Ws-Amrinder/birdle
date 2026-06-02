import 'dart:async';

import 'package:birdle/providers/themeProvider.dart';
import 'package:birdle/screens/home.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // call apis instead of this timer, as soon as the api response is received, push the home screen
    // temporarily keeping the timer of 2 s here
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeNotifier>(context).getTheme();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Image.asset('assets/appIconLight.png', width: 150),
                Text('Taches', style: TextStyle(fontSize: 44)),
                Text(
                  'Stay on top of it.',
                  style: TextStyle(
                    fontSize: 24,
                    color: TColors.textSecondary(appTheme),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
