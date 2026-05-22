import 'package:flutter/material.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


Future<void> saveTask(Map<String, String> task) async {
  final prefs = await SharedPreferencesAsync();
  await prefs.setString('tasks', jsonEncode(task));
}

/// Reads stored task JSON. Handles current format and legacy `jsonEncode(map.toString())`.
Task? parseStoredTask(String value) {
  if (value.isEmpty) return null;

  try {
    final decoded = jsonDecode(value);
    if (decoded is Map<String, dynamic>) {
      return Task.fromJson(decoded);
    }
    if (decoded is Map) {
      return Task.fromJson(Map<String, dynamic>.from(decoded));
    }
    if (decoded is String) {
      return Task.fromJson(_legacyMapFromDartString(decoded));
    }
  } catch (_) {
    return null;
  }
  return null;
}

Map<String, dynamic> _legacyMapFromDartString(String s) {
  final inner = s.trim();
  if (!inner.startsWith('{') || !inner.endsWith('}')) {
    throw const FormatException('Not a legacy map string');
  }
  final body = inner.substring(1, inner.length - 1);
  final map = <String, dynamic>{};
  for (final part in body.split(', ')) {
    final colon = part.indexOf(': ');
    if (colon == -1) continue;
    map[part.substring(0, colon).trim()] = part.substring(colon + 2).trim();
  }
  return map;
}

class Task {
  final String taskName;
  final String taskDescription;
  final String taskDate;
  final String taskTime;
  final String taskCategory;
  final String taskPriority;

  Task({
    required this.taskName,
    required this.taskDescription,
    required this.taskDate,
    required this.taskTime,
    required this.taskCategory,
    required this.taskPriority,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json['taskName'] as String? ?? '',
      taskDescription: json['taskDescription'] as String? ?? '',
      taskDate: json['taskDate'] as String? ?? '',
      taskTime: json['taskTime'] as String? ?? '',
      taskCategory: json['taskCategory'] as String? ?? '',
      taskPriority: json['taskPriority'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'taskName': taskName,
        'taskDescription': taskDescription,
        'taskDate': taskDate,
        'taskTime': taskTime,
        'taskCategory': taskCategory,
        'taskPriority': taskPriority,
      };
}

class AddTaskDrawer extends StatefulWidget {
  @override
  State<AddTaskDrawer> createState() => _AddTaskDrawerState();
}

class _AddTaskDrawerState extends State<AddTaskDrawer> {
  String selectedCategoryId = "work";
  String selectedPriorityId = "low";

  // final asyncPrefs = await SharedPreferencesAsync();
  List<String> savedTasks = [];
 

  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDateController = TextEditingController();
  final taskTimeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskNameController.dispose();
    taskDescriptionController.dispose();
    taskDateController.dispose();
    taskTimeController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final taskNameVal = taskNameController.text;
    final taskDescVal = taskDescriptionController.text;
    final taskDateVal = taskDateController.text;
    final taskTimeVal = taskTimeController.text;

    Map<String, String> taskMap = {
      "taskName": taskNameVal,
      "taskDescription": taskDescVal,
      "taskDate": taskDateVal,
      "taskTime": taskTimeVal,
      "taskCategory": selectedCategoryId,
      "taskPriority": selectedPriorityId,
    };

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Add Task', style: TextStyle(fontSize: 24)),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Name"),
                    TextField(
                      controller: taskNameController,
                      decoration: InputDecoration(
                        filled: true, // Required for fillColor to take effect
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        hintText: 'Enter Task Name',
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Description"),
                    TextField(
                      controller: taskDescriptionController,
                      decoration: InputDecoration(
                        filled: true, // Required for fillColor to take effect
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        hintText: 'Enter Task Description',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Date & Time"),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: taskDateController,
                            decoration: InputDecoration(
                              filled: true, // Required for fillColor to take effect
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                              hintText: 'DD/MM/YYYY',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: taskTimeController,
                            decoration: InputDecoration(
                              filled: true, // Required for fillColor to take effect
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD3D1C7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                              // labelText: 'Task Date',
                              hintText: 'HH:MM',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category"),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            children: [
                              TagCard(
                                tag: "Work",
                                id: "work",
                                selectedTagId: selectedCategoryId,
                                onTagPressed: (id) {
                                  setState(() {
                                    selectedCategoryId = id;
                                  });
                                },
                              ),
                              TagCard(
                                tag: "Personal",
                                id: "personal",
                                selectedTagId: selectedCategoryId,
                                onTagPressed: (id) {
                                  setState(() {
                                    selectedCategoryId = id;
                                  });
                                },
                              ),
                              TagCard(
                                tag: "Health",
                                id: "health",
                                selectedTagId: selectedCategoryId,
                                onTagPressed: (id) {
                                  setState(() {
                                    selectedCategoryId = id;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Priority"),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            children: [
                              TagCard(
                                tag: "Low",
                                color: Color(0xFF3B6D11),
                                foregroundColor: Colors.white,
                                id: "low",
                                selectedTagId: selectedPriorityId,
                                onTagPressed: (id) {
                                  setState(() {
                                    selectedPriorityId = id;
                                  });
                                },
                              ),
                              TagCard(
                                tag: "Medium",
                                color: const Color.fromARGB(255, 238, 165, 56),
                                foregroundColor: Color(0xFFFAC775),
                                id: "medium",
                                selectedTagId: selectedPriorityId,
                                onTagPressed: (id) {
                                  setState(() {
                                    selectedPriorityId = id;
                                  });
                                },
                              ),
                              TagCard(
                                tag: "High",
                                color: Colors.red,
                                foregroundColor: Colors.white,
                                id: "high",
                                selectedTagId: selectedPriorityId,
                                onTagPressed: (id) {
                                  setState(() {
                                    selectedPriorityId = id;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  onPressed: ()async {
                    // await SharedPreferencesAsync.setInt('taskCount', taskCount + 1);
                    await saveTask(taskMap);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          "Add Task",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
