import 'dart:async';
import 'package:birdle/bloc/theme/theme_bloc.dart';
import 'package:birdle/bloc/theme/theme_state.dart';
import 'package:birdle/screens/home.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final appTheme = themeState.theme;
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
      },
    );
  }
}
