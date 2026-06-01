import 'package:birdle/components/commons/confirmDialog.dart';
import 'package:birdle/components/commons/datePicker.dart';
import 'package:birdle/components/commons/timePicker.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:birdle/task_storage.dart';
import 'package:flutter/material.dart';
import 'package:birdle/components/taskItem.dart';
import 'package:birdle/providers/taskProvider.dart';
import 'package:provider/provider.dart';

class UpdateItem extends StatefulWidget {
  final Map<String, dynamic> entry;
  final String taskDate;
  const UpdateItem({required this.entry, required this.taskDate});

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
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
        "taskCategory": context.read<TaskNotifier>().getSelectedCategoryId(),
        "taskPriority": context.read<TaskNotifier>().getSelectedPriorityId(),
      };
      await updateTask(updatedEntry, widget.taskDate);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    String tappedId = Provider.of<TaskNotifier>(context).getSelectedTaskId();

    final updateNameVal = updateNameController.text;
    final updateDescVal = updateDescriptionController.text;
    final updateDateVal = updateDateController.text;
    final updateTimeVal = updateTimeController.text;

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 30),
        child: SingleChildScrollView(child: Container(
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
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // shrink to fit
                          children: [
                            Icon(Icons.arrow_back, color: Color(0xFF2C2C2A)),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2C2C2A),
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
                      TextFormField(
                        maxLines: 4,
                        controller: updateDescriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task Description is required';
                          }
                          return null;
                        },
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
                            child: 
                            DatePicker(
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
                            child: 
                            TimePicker(
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
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedCategoryId(),
                                  onTagPressed: (id) {
                                    // setState(() {
                                    //   selectedCategoryId = id;
                                    // });
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
                                    // setState(() {
                                    //   selectedCategoryId = id;
                                    // });
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
                                    // setState(() {
                                    //   selectedCategoryId = id;
                                    // });
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
                                  color: Color(0xFF3B6D11),
                                  id: "low",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedPriorityId(),
                                  onTagPressed: (id) {
                                    // setState(() {
                                    //   selectedPriorityId = id;
                                    // });
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedPriorityId(id);
                                  },
                                ),
                                TagCard(
                                  tag: "Medium",
                                  color: const Color.fromARGB(
                                    255,
                                    238,
                                    165,
                                    56,
                                  ),
                                  id: "medium",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedPriorityId(),
                                  onTagPressed: (id) {
                                    // setState(() {
                                    //   selectedPriorityId = id;
                                    // });
                                    context
                                        .read<TaskNotifier>()
                                        .setSelectedPriorityId(id);
                                  },
                                ),
                                TagCard(
                                  tag: "High",
                                  color: Colors.red,
                                  id: "high",
                                  selectedTagId: context
                                      .read<TaskNotifier>()
                                      .getSelectedPriorityId(),
                                  onTagPressed: (id) {
                                    // setState(() {
                                    //   selectedPriorityId = id;
                                    // });
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
                      submitForm(context);
                      // Navigator.pop(context);
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
                            "Save Changes",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
