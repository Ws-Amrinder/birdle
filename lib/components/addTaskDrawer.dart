import 'package:birdle/components/commons/datePicker.dart';
import 'package:birdle/providers/themeProvider.dart';
import 'package:birdle/storage/task_storage.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:birdle/utils/theme/customThemes/inputTheme.dart';
import 'package:birdle/components/commons/timePicker.dart';
import 'package:birdle/providers/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class Task {
  final String taskName;
  final String taskDescription;
  final String taskDate;
  final String taskTime;
  final String taskCategory;
  final String taskPriority;
  final String taskId;

  Task({
    required this.taskName,
    required this.taskDescription,
    required this.taskDate,
    required this.taskTime,
    required this.taskCategory,
    required this.taskPriority,
    required this.taskId,
  });
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
  final uuid = Uuid();

  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDateController = TextEditingController();
  final taskTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskNameController.dispose();
    taskDescriptionController.dispose();
    taskDateController.dispose();
    taskTimeController.dispose();
    super.dispose();
  }

  submitForm(BuildContext context, Map<String, String> taskMap) async {
    if (formKey.currentState!.validate()) {
      bool success = await saveTask(taskMap);
      if (success) {
        Navigator.pop(context);
        context.read<TaskNotifier>().resetSelectedTaskId();
        context.read<TaskNotifier>().resetSelectedCategoryId();
        context.read<TaskNotifier>().resetSelectedPriorityId();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String uniqueId = uuid.v4();
    final appTheme = Provider.of<ThemeNotifier>(context).getTheme();
    final taskNameVal = taskNameController.text;
    final taskDescVal = taskDescriptionController.text;
    final taskDateVal = taskDateController.text;
    final taskTimeVal = taskTimeController.text;

    dynamic taskMap = {
      "taskName": taskNameVal,
      "taskDescription": taskDescVal,
      "taskDate": taskDateVal,
      "taskTime": taskTimeVal,
      "taskCategory": Provider.of<TaskNotifier>(
        context,
      ).getSelectedCategoryId(),
      "taskPriority": Provider.of<TaskNotifier>(
        context,
      ).getSelectedPriorityId(),
      "taskId": uuid.v1(),
      "status": "active",
      "taskCreatedAt": DateTime.now().toIso8601String(),
    };

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),

        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Add Task',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Task Name"),
                      TextFormField(
                        maxLength: 20,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task Name is required';
                          }
                          return null;
                        },
                        controller: taskNameController,
                        decoration: TInputTheme.fieldDecoration(
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
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task Description is required';
                          }
                          return null;
                        },

                        maxLines: 4,
                        controller: taskDescriptionController,
                        decoration: TInputTheme.fieldDecoration(
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
                            child: DatePicker(
                              controller: taskDateController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: TimePicker(
                              controller: taskTimeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Time is required';
                                }
                                return null;
                              },
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

                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedCategoryId(),
                                  onTagPressed: (id) {
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedCategoryId(id);
                                  },
                                ),
                                TagCard(
                                  tag: "Personal",
                                  id: "personal",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedCategoryId(),
                                  onTagPressed: (id) {
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedCategoryId(id);
                                  },
                                ),
                                TagCard(
                                  tag: "Health",
                                  id: "health",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedCategoryId(),
                                  onTagPressed: (id) {
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedCategoryId(id);
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
                                  color: TColors.success,
                                  id: "low",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedPriorityId(),
                                  onTagPressed: (id) {
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedPriorityId(id);
                                  },
                                ),
                                TagCard(
                                  tag: "Medium",
                                  color: TColors.warning,
                                  id: "medium",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedPriorityId(),
                                  onTagPressed: (id) {
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedPriorityId(id);
                                  },
                                ),
                                TagCard(
                                  tag: "High",
                                  color: TColors.danger,
                                  id: "high",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedPriorityId(),
                                  onTagPressed: (id) {
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedPriorityId(id);
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
                    onPressed: () async {
                      submitForm(context, taskMap);
                    },
                    style: TButtonTheme.primaryTextButton(appTheme),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            "Add Task",
                            style: TextStyle(
                              color: TColors.white(appTheme),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
