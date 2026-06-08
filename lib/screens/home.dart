import 'package:birdle/bloc/task/task_bloc.dart';
import 'package:birdle/bloc/task/task_event.dart';
import 'package:birdle/bloc/task/task_state.dart';
import 'package:birdle/bloc/theme/theme_bloc.dart';
import 'package:birdle/bloc/theme/theme_event.dart';
import 'package:birdle/bloc/theme/theme_state.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:flutter/material.dart';
import 'package:birdle/components/addTaskDrawer.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:birdle/components/taskcard.dart';
import 'package:birdle/components/taskItem.dart';
import 'package:birdle/storage/task_storage.dart';
import 'package:birdle/screens/viewItem.dart';
import 'package:birdle/providers/taskProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String selectedTagId = "all";
  String tasks = "";
  double completedTasksPercentage = 0;
  List<Map<String, dynamic>> tasksList = [];
  double progressToday = 0;
  int totalTasksToday = 0;
  int completedTasksToday = 0;

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final value = await getTasks();
    if (!mounted) return;

    List<Map<String, dynamic>?> filteredTasks = value.toList();

    final currentDate = DateTime.now();
    final todayTasks = filteredTasks.where((element) {
      final splittedDate = element!["taskDate"]?.split('/') ?? [];

      if (int.parse(splittedDate[0]) == currentDate.day &&
          int.parse(splittedDate[1]) == currentDate.month &&
          int.parse(splittedDate[2]) == currentDate.year) {
        return true;
      }

      return false;
    });

    final totalTasks = todayTasks.first!["tasks"]!.length;
    final completedTasks = todayTasks.first!["tasks"]!
        .where((element) => element["status"] == "done")
        .length;

    if (selectedTagId == "done") {
      filteredTasks = value
          .toList()
          .map((element) {
            final tasks = element["tasks"].where(
              (task) => task["status"] == "done",
            );
            if (tasks.isNotEmpty) {
              return {...element, "tasks": tasks.toList()};
            }
            return null;
          })
          .where((element) => element != null)
          .toList();
    } else if (selectedTagId == "active") {
      filteredTasks = value
          .toList()
          .map((element) {
            final tasks = element["tasks"].where(
              (task) => task["status"] == "active",
            );
            if (tasks.isNotEmpty) {
              return {...element, "tasks": tasks.toList()};
            }
            return {...element, "tasks": []};
          })
          .where((element) => element != null)
          .toList();
    }

    setState(() {
      tasksList = List<Map<String, dynamic>>.from(filteredTasks);
      totalTasksToday = totalTasks;
      completedTasksToday = completedTasks;
      progressToday = completedTasksToday / totalTasksToday * 100;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate one-third of the screen width
    double myWidth = screenWidth / 3 - 20;

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          buildWhen: (previous, current) => previous.theme != current.theme,
          builder: (context, themeState) {
            final appTheme = themeState.theme;
            return Scaffold(
              key: _scaffoldKey,

              body: SafeArea(
                minimum: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 60,
                  bottom: 30,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'My Tasks',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineLarge,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      // isDarkMode().then((value) {
                                      if (themeState.theme == 'dark') {
                                        // ref.read(setCurrentTheme('light'));
                                        // ref.invalidate(currentTheme);
                                        context.read<ThemeBloc>().add(
                                          SelectTheme(theme: 'light'),
                                        );
                                      } else {
                                        // ref.read(setCurrentTheme('dark'));
                                        // ref.invalidate(currentTheme);
                                        context.read<ThemeBloc>().add(
                                          SelectTheme(theme: 'dark'),
                                        );
                                      }
                                      // });
                                    },
                                    icon: Icon(
                                      themeState.theme == 'dark'
                                          ? Icons.light_mode
                                          : Icons.dark_mode,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  formattedDate,
                                  style: Theme.of(
                                    context,
                                  ).textTheme?.bodyMedium,
                                ),
                              ),

                              // task cards
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    TaskCard(
                                      title: totalTasksToday.toString(),
                                      description: 'Total',
                                      myWidth: myWidth,
                                    ),
                                    Spacer(),
                                    TaskCard(
                                      title: completedTasksToday.toString(),
                                      description: 'Done',
                                      myWidth: myWidth,
                                    ),
                                    Spacer(),
                                    TaskCard(
                                      title:
                                          (totalTasksToday -
                                                  completedTasksToday)
                                              .toString(),
                                      description: 'Left',
                                      myWidth: myWidth,
                                    ),
                                  ],
                                ),
                              ),

                              // progress labels
                              Row(
                                children: [
                                  Text(
                                    "Today's Progress",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: TColors.textSecondary(appTheme),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    progressToday.toStringAsFixed(0) + '%',

                                    // completedTasksPercentage,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: TColors.textSecondary(appTheme),
                                    ),
                                  ),
                                ],
                              ),

                              // progress bar
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final progressFraction =
                                        (progressToday / 100).clamp(0.0, 1.0);
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          148,
                                          211,
                                          209,
                                          199,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 10,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: TColors.primary(appTheme),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          width:
                                              constraints.maxWidth *
                                              progressFraction,
                                          height: 10,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // tags
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Wrap(
                                        children: [
                                          TagCard(
                                            tag: "All",
                                            id: "all",
                                            selectedTagId: selectedTagId,
                                            onTagPressed: (id) {
                                              setState(() {
                                                selectedTagId = id;
                                              });
                                              _loadTasks();
                                            },
                                          ),

                                          TagCard(
                                            tag: "Active",
                                            id: "active",
                                            selectedTagId: selectedTagId,
                                            onTagPressed: (id) {
                                              setState(() {
                                                selectedTagId = id;
                                              });
                                              _loadTasks();
                                            },
                                          ),

                                          TagCard(
                                            tag: "Done",
                                            id: "done",
                                            selectedTagId: selectedTagId,
                                            onTagPressed: (id) {
                                              setState(() {
                                                selectedTagId = id;
                                              });
                                              _loadTasks();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (tasksList.isEmpty ||
                                  tasksList.first["tasks"]!.isEmpty)
                                Padding(
                                  padding: EdgeInsets.only(top: 100),
                                  child: Column(
                                    children: [
                                      Text(
                                        "All caught up!",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "No completed tasks yet. \n Start checking things off.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: TColors.textSecondary(
                                            appTheme,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                for (var entry in tasksList)
                                  if (entry["tasks"].isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Column(
                                        spacing: 0,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              child: Text(
                                                entry["taskDate"] ?? "",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: TColors.textSecondary(
                                                    appTheme,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          for (var taskEntry
                                              in entry["tasks"] as List)
                                            TaskItem(
                                              title:
                                                  taskEntry["taskName"] ?? "",
                                              category:
                                                  taskEntry["taskCategory"] ??
                                                  "",
                                              description:
                                                  taskEntry["taskDescription"] ??
                                                  "",
                                              id: taskEntry["taskId"] ?? "",
                                              tappedId: ref
                                                  .read(selectedTaskId.notifier)
                                                  .state,
                                              date: taskEntry["taskDate"] ?? "",
                                              time: taskEntry["taskTime"] ?? "",
                                              priority:
                                                  taskEntry["taskPriority"] ??
                                                  "",
                                              status: taskEntry["status"] ?? "",
                                              onTap: (id) {
                                                // riverpod state set
                                                // ref.read(selectedTaskId.notifier).state = id;
                                                // ref.read(selectedCategoryId.notifier).state = taskEntry["taskCategory"] ?? "";
                                                // ref.read(selectedPriorityId.notifier).state = taskEntry["taskPriority"] ?? "";

                                                context.read<TaskBloc>().add(
                                                  SelectTask(
                                                    selectedTaskId: id,
                                                  ),
                                                );
                                                context.read<TaskBloc>().add(
                                                  SelectCategory(
                                                    selectedCategoryId: id,
                                                  ),
                                                );
                                                context.read<TaskBloc>().add(
                                                  SelectPriority(
                                                    selectedPriorityId: id,
                                                  ),
                                                );

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewUpdateItem(
                                                          entry: taskEntry,
                                                          taskDate:
                                                              entry["taskDate"] ??
                                                              "",
                                                        ),
                                                  ),
                                                ).then((value) {
                                                  _loadTasks();
                                                  if (mounted) {
                                                    context
                                                        .read<TaskBloc>()
                                                        .add(
                                                          ResetTaskSelection(),
                                                        );
                                                  }
                                                  // context.read<TaskBloc>().add(SelectTask(selectedTaskId: ""));
                                                  // context.read<TaskBloc>().add(SelectCategory(selectedCategoryId: ""));
                                                  // context.read<TaskBloc>().add(SelectPriority(selectedPriorityId: ""));
                                                });
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: ElevatedButton(
                          style: TButtonTheme.primaryElevatedButton(appTheme)
                              .copyWith(
                                shape: WidgetStateProperty.all(CircleBorder()),
                              ),
                          onPressed: () async {
                            await showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return AddTaskDrawer();
                              },
                              backgroundColor: TColors.background(appTheme),
                            );
                            _loadTasks();
                          },
                          child: Icon(
                            Icons.add,
                            color: TColors.white(appTheme),
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
