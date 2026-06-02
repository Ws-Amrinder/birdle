import 'package:birdle/components/commons/confirmDialog.dart';
import 'package:birdle/providers/themeProvider.dart';
import 'package:birdle/screens/updateItem.dart';
import 'package:birdle/storage/task_storage.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:flutter/material.dart';
import 'package:birdle/components/taskItem.dart';
import 'package:birdle/providers/taskProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewUpdateItem extends StatefulWidget {
  final Map<String, dynamic> entry;
  final String taskDate;
  const ViewUpdateItem({required this.entry, required this.taskDate});

  @override
  State<ViewUpdateItem> createState() => _ViewUpdateItemState();
}

class _ViewUpdateItemState extends State<ViewUpdateItem> {
  Map<String, dynamic> itemData = {};

  @override
  void initState() {
    super.initState();

    setState(() {
      itemData = widget.entry;
    });

    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final value = await getTasks();
    if (!mounted) return;
    setState(() {
      final elementWithSameDate = value.where(
        (element) => element["taskDate"] == widget.taskDate,
      );
      final found = elementWithSameDate.first["tasks"].where(
        (element) => element["taskId"] == widget.entry["taskId"],
      );
      if (found.isNotEmpty) {
        itemData = Map<String, dynamic>.from(found.first);
        final createdAt = DateFormat(
          'dd/MM/yyyy',
        ).format(DateTime.parse(widget.entry["taskCreatedAt"]));

        final createTime = DateFormat(
          'HH:mm a',
        ).format(DateTime.parse(widget.entry["taskCreatedAt"]));

        if (itemData["taskCreatedAt"] != null) {
          itemData["taskCreatedAt"] = "$createdAt $createTime";
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeNotifier>(context).getTheme();

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 30),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(color: TColors.background(appTheme)),
            child: Column(
              spacing: 15,
              children: [
                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: TButtonTheme.transparentTextButton(appTheme)
                          .copyWith(
                            padding: WidgetStateProperty.all(EdgeInsets.all(0)),
                          ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: TColors.primary(appTheme),
                          ),
                          Text(
                            'Back',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: TColors.primary(appTheme)),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        if (itemData["status"] != "done")
                          IconButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              // push to edit item screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateItem(
                                    entry: itemData,
                                    taskDate: widget.taskDate,
                                  ),
                                ),
                              ).then((updated) {
                                if (updated == true) _loadTasks();
                              });
                            },
                            icon: Icon(Icons.edit, size: 20),
                            constraints: BoxConstraints(),
                            style: IconButton.styleFrom(
                              backgroundColor: TColors.white(appTheme),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: TColors.border(appTheme),
                                width: 1,
                              ),
                            ),
                          ),

                        IconButton(
                          onPressed: () {
                            confirmDialog(
                              context,
                              'Delete Task',
                              'Are you sure you want to delete this task?',
                              () async {
                                final result = await deleteTask(
                                  itemData["taskId"],
                                  widget.taskDate,
                                );
                                if (result) {
                                  context
                                      .read<TaskNotifier>()
                                      .resetSelectedTaskId();
                                  context
                                      .read<TaskNotifier>()
                                      .resetSelectedCategoryId();
                                  context
                                      .read<TaskNotifier>()
                                      .resetSelectedPriorityId();
                                  _loadTasks();
                                  Navigator.pop(context);
                                }
                              },
                              () {},
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                          constraints: BoxConstraints(),
                          style: IconButton.styleFrom(
                            backgroundColor: TColors.white(appTheme),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: TColors.border(appTheme),
                              width: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                if (itemData["status"] == "done")
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Container(
                      // color: Colors.green,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: TColors.green200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: TColors.success,
                            size: 40,
                          ),
                          Text(
                            "Task Completed!",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Color(0xFF3B6D11),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            "Done today at 9:12 AM",
                            style: TextStyle(color: Color(0xFF3B6D11)),
                          ),
                        ],
                      ),
                    ),
                  ),

                // item listing card
                TaskItem(
                  title: itemData["taskName"] ?? "",
                  category: itemData["taskCategory"] ?? "",
                  description: "",
                  id: itemData["taskId"] ?? "",
                  tappedId: "",
                  date: "",
                  time: "",
                  status: itemData["status"] ?? "",
                  isLargeView: true,
                  priority: itemData["taskPriority"] ?? "",
                  onTap: (id) {
                    context.read<TaskNotifier>().setSelectedTaskId(id);
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.white(appTheme),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColors.border(appTheme)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: TColors.primary(appTheme),
                                size: 20,
                              ),
                              SizedBox(width: 15),
                              Text("Due"),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                itemData["taskDate"] ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(width: 10),
                              Text(
                                itemData["taskTime"] ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // task category
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.white(appTheme),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColors.border(appTheme)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.folder_outlined,
                                color: TColors.primary(appTheme),
                                size: 20,
                              ),
                              SizedBox(width: 15),
                              Text("Category"),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                itemData["taskCategory"] ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // created at
                if (itemData["taskCreatedAt"] != null)
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: TColors.white(appTheme),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: TColors.border(appTheme)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: TColors.primary(appTheme),
                                  size: 20,
                                ),
                                SizedBox(width: 15),
                                Text("Created at"),
                              ],
                            ),

                            Text(itemData["taskCreatedAt"] ?? ""),
                          ],
                        ),
                      ),
                    ),
                  ),

                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.white(appTheme),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColors.border(appTheme)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.note_add_outlined,
                                color: TColors.primary(appTheme),
                                size: 20,
                              ),
                              SizedBox(width: 15),
                              Text("Notes"),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                itemData["taskDescription"] ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                if (itemData["status"] != "done")
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final updatedEntry = {
                            ...itemData,
                            "status": "done",
                            "updatedAt": DateTime.now().toIso8601String(),
                          };

                          await updateTask(updatedEntry, widget.taskDate);
                          _loadTasks();
                          // Navigator.pop(context);
                        },
                        style: TButtonTheme.primaryElevatedButton(appTheme),
                        child: SizedBox(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text(
                                "Mark as done",
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
