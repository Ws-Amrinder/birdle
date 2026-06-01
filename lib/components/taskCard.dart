import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD3D3D3)),
      ),
      width: myWidth,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(title, style: Theme.of(context).textTheme?.headlineLarge),
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
