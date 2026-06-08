import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

Future<List<Map<String, dynamic>>> getTasks() async {
  final prefs = await SharedPreferencesAsync();
  final taskJson = await prefs.getString('tasks') ?? '';
  if (taskJson.isEmpty) return [];

  final decoded = jsonDecode(taskJson);
  if (decoded is List) {
    final newList = decoded
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    newList.sort((a, b) => b['taskDate'].compareTo(a['taskDate']));
    return newList;
  }
  return [];
}

Future<bool> saveTask(Map<String, String> task) async {
  try {
    final prefs = await SharedPreferencesAsync();
    final existing = await getTasks();

    final currentDate = DateTime.now().toIso8601String();
    final taskDate = DateUtils.dateOnly(DateTime.parse(currentDate));

    task["updatedAt"] = currentDate;
    final now = DateTime.now();
    final dayKey =
        '${now.day}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().padLeft(2, '0')}';

    final tasksWithSameDate = existing.where(
      (e) => (e['taskDate'] as String?) == dayKey,
    );

    if (tasksWithSameDate.isNotEmpty) {
      tasksWithSameDate.first["tasks"] = List.from(
        tasksWithSameDate.first["tasks"],
      );
      tasksWithSameDate.first["tasks"].add(task);
      await prefs.setString('tasks', jsonEncode(existing));
      return true;
    }

    existing.add({
      "taskDate": "${dayKey}",
      "tasks": [task],
    });
    await prefs.setString('tasks', jsonEncode(existing));
    return true;
  } catch (e, stackTrace) {
    print("error: ${e}");
    print("stackTrace: ${stackTrace}");
    return false;
  }
}

Future<bool> updateTask(Map<String, dynamic> task, String taskDate) async {
  final prefs = await SharedPreferencesAsync();
  final existing = await getTasks();

  final tasksWithSameDate = existing.where(
    (element) => element["taskDate"] == taskDate,
  );
  tasksWithSameDate.first["tasks"].removeWhere(
    (element) => element['taskId'] == task['taskId'],
  );
  tasksWithSameDate.first["tasks"].add(Map<String, dynamic>.from(task));

  await prefs.setString('tasks', jsonEncode(existing));
  return true;
}

Future<bool> deleteTask(String taskId, String taskDate) async {
  final prefs = await SharedPreferencesAsync();
  final existing = await getTasks();
  final tasksWithSameDate = existing.where(
    (element) => element["taskDate"] == taskDate,
  );
  tasksWithSameDate.first["tasks"].removeWhere(
    (element) => element['taskId'] == taskId,
  );

  if (tasksWithSameDate.first["tasks"].isEmpty) {
    existing.removeWhere((element) => element["taskDate"] == taskDate);
  }

  await prefs.setString('tasks', jsonEncode(existing));
  return true;
}
