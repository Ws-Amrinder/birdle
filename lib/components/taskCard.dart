import 'package:birdle/bloc/theme/theme_bloc.dart';
import 'package:birdle/bloc/theme/theme_state.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends ConsumerWidget {
  final String title;
  final String description;
  final double myWidth;

  TaskCard({
    required this.title,
    required this.description,
    required this.myWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final appTheme = themeState.theme;
        return Container(
          decoration: BoxDecoration(
            color: TColors.white(appTheme),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: TColors.lightBorder(appTheme)),
          ),
          width: myWidth,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme?.headlineLarge,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme?.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
