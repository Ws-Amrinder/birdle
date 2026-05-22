import 'package:flutter/material.dart';
import 'package:birdle/components/addTaskDrawer.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:birdle/components/taskcard.dart';
import 'package:birdle/components/taskItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getTasks() async {
  final prefs = await SharedPreferencesAsync();
  final taskJson = await prefs.getString('tasks');
  if (taskJson == null || taskJson.isEmpty) {
    return ''; // or {'tasks': []} — whatever shape you expect
  }
  return taskJson;
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String selectedTagId = "all";
  String selectedCategoryId = "work";
  String selectedPriorityId = "low";
  String tappedId = "1";
  String tasks = "";
  Map<String, String> tasksMap = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate one-third of the screen width
    double myWidth = screenWidth / 3 - 20;

    getTasks().then((value) {
      if (value.isEmpty) return;
      print("tasks: $value");
      tasksMap = parseStoredTask(value);
      if (tasksMap == null) return;
      print("tasksMap: $tasksMap, ${tasksMap.taskName}");
    });

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: const Color(0xFFF5F3EE)),
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('My Tasks', style: TextStyle(fontSize: 24)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '19 May 2026',
                      style: TextStyle(fontSize: 16, color: Color(0xFF888780)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        TaskCard(
                          title: '8',
                          description: 'Total',
                          myWidth: myWidth,
                        ),
                        Spacer(),
                        TaskCard(
                          title: '3',
                          description: 'Done',
                          myWidth: myWidth,
                        ),
                        Spacer(),
                        TaskCard(
                          title: '5',
                          description: 'Left',
                          myWidth: myWidth,
                        ),
                      ],
                    ),
                  ),

                  // progress bar
                  Row(
                    children: [
                      Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF888780),
                        ),
                      ),
                      Spacer(),
                      Text(
                        '40%',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF888780),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(148, 211, 209, 199),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: screenWidth,
                      height: 10,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF000000),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: screenWidth * 0.4,
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),

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
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  tasks.forEach((key, value) {
                    TaskItem(
                      title: value["taskName"],
                      description: value["taskDescription"],
                      id: key,
                      tappedId: tappedId,
                      onTap: (id) {
                        setState(() {
                          tappedId = id;
                        });
                      },
                      tasks: value,
                    );
                  });

                  TaskItem(
                    title: "Review PR #42",
                    description: "19 May 2026",
                    id: "1",
                    tappedId: tappedId,
                    onTap: (id) {
                      setState(() {
                        tappedId = id;
                      });
                    },
                    tasks: tasksMap,
                  ),
                  TaskItem(
                    title: "Review PR #42",
                    description: "19 May 2026",
                    id: "2",
                    tappedId: tappedId,
                    onTap: (id) {
                      setState(() {
                        tappedId = id;
                      });
                    },
                  ),
                  TaskItem(
                    title: "Review PR #42",
                    description: "19 May 2026",
                    id: "3",
                    tappedId: tappedId,
                    onTap: (id) {
                      setState(() {
                        tappedId = id;
                      });
                    },
                  ),
                  TaskItem(
                    title: "Review PR #42",
                    description: "19 May 2026",
                    id: "4",
                    tappedId: tappedId,
                    onTap: (id) {
                      setState(() {
                        tappedId = id;
                      });
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                      shape: WidgetStateProperty.all(CircleBorder()),
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return AddTaskDrawer();
                        },
                        backgroundColor: const Color(0xFFF5F3EE),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
