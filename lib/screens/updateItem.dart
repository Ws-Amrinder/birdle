import 'package:birdle/bloc/task/task_bloc.dart';
import 'package:birdle/bloc/task/task_event.dart';
import 'package:birdle/bloc/task/task_state.dart';
import 'package:birdle/bloc/theme/theme_bloc.dart';
import 'package:birdle/bloc/theme/theme_state.dart';
import 'package:birdle/storage/task_storage.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:birdle/utils/theme/customThemes/inputTheme.dart';
import 'package:birdle/components/commons/datePicker.dart';
import 'package:birdle/components/commons/timePicker.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:flutter/material.dart';
import 'package:birdle/providers/taskProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateItem extends ConsumerStatefulWidget {
  final Map<String, dynamic> entry;
  final String taskDate;
  const UpdateItem({required this.entry, required this.taskDate});

  @override
  ConsumerState<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends ConsumerState<UpdateItem> {
  final updateNameController = TextEditingController(text: '');
  final updateDescriptionController = TextEditingController(text: '');
  final updateDateController = TextEditingController(text: '');
  final updateTimeController = TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    updateNameController.text = widget.entry['taskName'] ?? '';
    updateDescriptionController.text = widget.entry['taskDescription'] ?? '';
    updateDateController.text = widget.entry['taskDate'] ?? '';
    updateTimeController.text = widget.entry['taskTime'] ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    updateNameController.dispose();
    updateDescriptionController.dispose();
    updateDateController.dispose();
    updateTimeController.dispose();
  }

  submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      print('Form is valid');
      final updatedEntry = {
        ...widget.entry,
        "taskName": updateNameController.text,
        "taskDescription": updateDescriptionController.text,
        "taskDate": updateDateController.text,
        "taskTime": updateTimeController.text,
        "taskCategory": ref.watch(selectedCategoryId),
        "taskPriority": ref.watch(selectedPriorityId),
      };
      await updateTask(updatedEntry, widget.taskDate);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final categoryId = state.selectedCategoryId;
        final priorityId = state.selectedPriorityId;

        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final appTheme = themeState.theme;
            return Scaffold(
              body: SafeArea(
                minimum: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 60,
                  bottom: 30,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.centerLeft,

                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // header
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Centered text
                              Text(
                                "Edit Task",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // Back button aligned to the left
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    context.read<TaskBloc>().add(
                                      SelectCategory(selectedCategoryId: ""),
                                    );
                                    context.read<TaskBloc>().add(
                                      SelectPriority(selectedPriorityId: ""),
                                    );

                                    Navigator.pop(context);
                                  },
                                  style:
                                      TButtonTheme.transparentTextButton(
                                        appTheme,
                                      ).copyWith(
                                        padding: WidgetStateProperty.all(
                                          EdgeInsets.all(0),
                                        ),
                                      ),
                                  child: Row(
                                    mainAxisSize:
                                        MainAxisSize.min, // shrink to fit
                                    children: [
                                      Icon(
                                        Icons.arrow_back,
                                        color: TColors.primary(appTheme),
                                      ),
                                      Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: TColors.primary(appTheme),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Task Name"),
                                TextFormField(
                                  maxLength: 20,
                                  controller: updateNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Task Name is required';
                                    }
                                    return null;
                                  },
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
                                  maxLines: 4,
                                  controller: updateDescriptionController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Task Description is required';
                                    }
                                    return null;
                                  },
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
                                        controller: updateDateController,
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
                                        controller: updateTimeController,
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
                                              context.read<TaskBloc>().add(
                                                SelectCategory(
                                                  selectedCategoryId: id,
                                                ),
                                              );
                                            },
                                          ),
                                          TagCard(
                                            tag: "Personal",
                                            id: "personal",
                                            selectedTagId: categoryId,
                                            onTagPressed: (id) {
                                              context.read<TaskBloc>().add(
                                                SelectCategory(
                                                  selectedCategoryId: id,
                                                ),
                                              );
                                            },
                                          ),
                                          TagCard(
                                            tag: "Health",
                                            id: "health",
                                            selectedTagId: categoryId,
                                            onTagPressed: (id) {
                                              context.read<TaskBloc>().add(
                                                SelectCategory(
                                                  selectedCategoryId: id,
                                                ),
                                              );
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
                                              context.read<TaskBloc>().add(
                                                SelectPriority(
                                                  selectedPriorityId: id,
                                                ),
                                              );
                                            },
                                          ),
                                          TagCard(
                                            tag: "Medium",
                                            color: TColors.warning,
                                            id: "medium",
                                            selectedTagId: priorityId,
                                            onTagPressed: (id) {
                                              context.read<TaskBloc>().add(
                                                SelectPriority(
                                                  selectedPriorityId: id,
                                                ),
                                              );
                                            },
                                          ),
                                          TagCard(
                                            tag: "High",
                                            color: TColors.danger,
                                            id: "high",
                                            selectedTagId: priorityId,
                                            onTagPressed: (id) {
                                              context.read<TaskBloc>().add(
                                                SelectPriority(
                                                  selectedPriorityId: id,
                                                ),
                                              );
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
                                submitForm(context);
                              },
                              style: TButtonTheme.primaryTextButton(appTheme),
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "Save Changes",
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
              ),
            );
          },
        );
      },
    );
  }
}
