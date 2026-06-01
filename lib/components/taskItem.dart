import 'package:flutter/material.dart';
import 'package:birdle/components/addTaskDrawer.dart';
import 'package:birdle/components/helpers/tasks.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final String id;
  final String tappedId;
  final Function(String id) onTap;
  final Task? tasks;
  final String category;
  final String date;
  final String time;
  final String status;
  final bool isLargeView;
  final String priority;

  TaskItem({
    required this.title,
    required this.description,
    required this.id,
    required this.tappedId,
    required this.onTap,
    this.tasks,
    required this.category,
    required this.date,
    required this.time,
    this.status = "active",
    this.isLargeView = false,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    Color clr = Colors.red;
    HSLColor hsl = HSLColor.fromColor(clr);
    double newLightness = (hsl.lightness + 0.3).clamp(0.0, 1.2);
    Color newColor = hsl.withLightness(newLightness).toColor();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          print("TaskItem tapped");
          onTap(id);
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFD85A30),
            borderRadius: BorderRadius.circular(10),
            border: Border(
              left: tappedId == id
                  ? BorderSide(color: const Color(0xFFD85A30))
                  : BorderSide.none,
            ),
          ),

          child: Padding(
            padding: tappedId == id
                ? EdgeInsets.only(left: 10)
                : EdgeInsets.only(left: 0),
            child: Container(
              decoration: BoxDecoration(
                // color: const Color(0xFFF5F3EE),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFD3D1C7)),
              ),

              // height: 10,
              child: Padding(
                padding: EdgeInsets.all(isLargeView ? 20 : 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          tappedId == id || status == "done"
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: tappedId == id ? Colors.green : Colors.grey,
                          size: isLargeView ? 40 : 30,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: isLargeView ? 26 : 16,
                                color: status == "done"
                                    ? Color(0xFF888780)
                                    : Colors.black,
                                decoration: status == "done"
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFF888780),
                              ),
                            ),

                            if (description.isNotEmpty)
                              SizedBox(
                                width: 220.0,
                                child: Text(
                                  description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF888780),
                                  ),
                                ),
                              ),

                            SizedBox(height: 5),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: HSLColor.fromColor(
                                      TaskHelper.getCategoryColor(category),
                                    ).withLightness(0.9).toColor(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: TaskHelper.getCategoryColor(
                                          category,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),

                                Container(
                                  decoration: BoxDecoration(
                                    color: HSLColor.fromColor(
                                      TaskHelper.getPriorityColor(priority),
                                    ).withLightness(0.9).toColor(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      priority,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: clr,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),

                                if (date.isNotEmpty)
                                  Text(
                                    date,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF888780),
                                    ),
                                  ),
                                SizedBox(width: 10),

                                if (time.isNotEmpty)
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF888780),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // );
  }
}
