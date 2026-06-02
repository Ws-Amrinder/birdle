import 'package:birdle/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TaskHelper {
  static Color getPriorityColor(String priority, String appTheme) {
    switch (priority) {
      case "low":
        return TColors.success;
      case "medium":
        return TColors.warning;
      case "high":
        return TColors.danger;
      default:
        return TColors.text(appTheme);
    }
  }

  static Color getCategoryColor(String category) {
    switch (category) {
      case "work":
        return TColors.blue;
      case "personal":
        return TColors.pink;
      default:
        return TColors.purple;
    }
  }
}
