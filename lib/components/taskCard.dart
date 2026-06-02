import 'package:birdle/providers/themeProvider.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final double myWidth;

  TaskCard({
    required this.title,
    required this.description,
    required this.myWidth,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeNotifier>(context).getTheme();

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
  }
}
