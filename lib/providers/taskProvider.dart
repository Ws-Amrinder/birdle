import 'package:flutter/material.dart';

class TaskNotifier extends ChangeNotifier {
  String selectedTaskId = "";
  String selectedCategoryId = "work";
  String selectedPriorityId = "low";

  void setSelectedTaskId(String id) {
    if (id == selectedTaskId) {
      selectedTaskId = "";
      notifyListeners();
    } else {
      selectedTaskId = id;
      notifyListeners();
    }
  }

  String getSelectedTaskId() {
    return selectedTaskId;
  }

void setSelectedCategoryId(String id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  void setSelectedPriorityId(String id) {
    selectedPriorityId = id;
    notifyListeners();
  }

  void resetSelectedTaskId() {
    selectedTaskId = "";
    notifyListeners();
  }

  void resetSelectedCategoryId() {
    selectedCategoryId = "work";
    notifyListeners();
  }

  void resetSelectedPriorityId() {
    selectedPriorityId = "low";
    notifyListeners();
  }
  String getSelectedCategoryId() {
    return selectedCategoryId;
  }

  String getSelectedPriorityId() {
    return selectedPriorityId;
  }

}
