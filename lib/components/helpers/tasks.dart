import 'package:flutter/material.dart';

class TaskHelper {
  static Color getPriorityColor(String priority) {
    switch (priority) {
      case "low":
        return Colors.green;
      case "medium":
        return Color.fromARGB(255, 238, 165, 56);
      case "high":
        return Colors.red;
      default:
        return Color(0xFF000000);
    }
  }

  static Color getCategoryColor(String category) {
    switch (category) {
      case "work":
        return Colors.blue;
      case "personal":
        return Colors.pink;
      default:
        return Colors.purple;
    }
  }
}
