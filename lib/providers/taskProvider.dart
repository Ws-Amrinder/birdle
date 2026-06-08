import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

// riverpod provider
final selectedTaskId = StateProvider<String>((ref) {
  return "";
});

final selectedCategoryId = StateProvider<String>((ref) {
  return "work";
});

final selectedPriorityId = StateProvider<String>((ref) {
  return "low";
});
