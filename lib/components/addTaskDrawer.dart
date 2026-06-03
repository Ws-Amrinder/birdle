import 'package:birdle/components/commons/datePicker.dart';
import 'package:birdle/providers/taskProvider.dart';
import 'package:birdle/storage/task_storage.dart';
import 'package:birdle/storage/theme_storage.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:birdle/utils/theme/customThemes/inputTheme.dart';
import 'package:birdle/components/commons/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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

class AddTaskDrawer extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddTaskDrawer> createState() => _AddTaskDrawerState();
}

class _AddTaskDrawerState extends ConsumerState<AddTaskDrawer> {
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
        ref.read(selectedTaskId.notifier).state = "";
        ref.read(selectedCategoryId.notifier).state = "";
        ref.read(selectedPriorityId.notifier).state = "";
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(currentTheme).value ?? '';
    final taskNameVal = taskNameController.text;
    final taskDescVal = taskDescriptionController.text;
    final taskDateVal = taskDateController.text;
    final taskTimeVal = taskTimeController.text;

    final categoryId = ref.watch(selectedCategoryId);
    final priorityId = ref.watch(selectedPriorityId);

    dynamic taskMap = {
      "taskName": taskNameVal,
      "taskDescription": taskDescVal,
      "taskDate": taskDateVal,
      "taskTime": taskTimeVal,
      "taskCategory": categoryId,
      "taskPriority": priorityId,
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

                                  selectedTagId: categoryId,
                                  onTagPressed: (id) {
                                    ref
                                            .read(selectedCategoryId.notifier)
                                            .state =
                                        id;
                                  },
                                ),
                                TagCard(
                                  tag: "Personal",
                                  id: "personal",
                                  selectedTagId: categoryId,
                                  onTagPressed: (id) {
                                    ref
                                            .read(selectedCategoryId.notifier)
                                            .state =
                                        id;
                                  },
                                ),
                                TagCard(
                                  tag: "Health",
                                  id: "health",
                                  selectedTagId: categoryId,
                                  onTagPressed: (id) {
                                    ref
                                            .read(selectedCategoryId.notifier)
                                            .state =
                                        id;
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
                                  selectedTagId: priorityId,
                                  onTagPressed: (id) {
                                    ref
                                            .read(selectedPriorityId.notifier)
                                            .state =
                                        id;
                                  },
                                ),
                                TagCard(
                                  tag: "Medium",
                                  color: TColors.warning,
                                  id: "medium",
                                  selectedTagId: priorityId,
                                  onTagPressed: (id) {
                                    ref
                                            .read(selectedPriorityId.notifier)
                                            .state =
                                        id;
                                  },
                                ),
                                TagCard(
                                  tag: "High",
                                  color: TColors.danger,
                                  id: "high",
                                  selectedTagId: priorityId,
                                  onTagPressed: (id) {
                                    ref
                                            .read(selectedPriorityId.notifier)
                                            .state =
                                        id;
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
