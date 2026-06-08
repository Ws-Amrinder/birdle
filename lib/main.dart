import 'package:birdle/bloc/task/task_bloc.dart';
import 'package:birdle/bloc/theme/theme_bloc.dart';
import 'package:birdle/bloc/theme/theme_event.dart';
import 'package:birdle/bloc/theme/theme_state.dart';
import 'package:birdle/screens/splash.dart';
import 'package:birdle/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeBloc()..add(const LoadTheme()),
          ),
          BlocProvider(create: (_) => TaskBloc()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          themeMode: themeState.theme == 'light'
              ? ThemeMode.light
              : ThemeMode.dark,
          home: SplashScreen(),
        );
      },
    );
  }
}
