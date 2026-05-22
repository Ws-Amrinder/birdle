import 'package:flutter/material.dart';
import 'package:birdle/components/tagCard.dart';
import 'package:birdle/components/addTaskDrawer.dart';


class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final String id;
  final String tappedId;
  final Function(String id) onTap;
  final Task? tasks;

  TaskItem({
    required this.title,
    required this.description,
    required this.id,
    required this.tappedId,
    required this.onTap,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {

    Color clr = Colors.red;
    HSLColor hsl = HSLColor.fromColor(clr);
    double newLightness = (hsl.lightness + 0.3).clamp(0.0, 1.2);
    Color newColor = hsl.withLightness(newLightness).toColor();

    // return Expanded(child:
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
            // border: Border.only(left: BorderSide(color: const Color.fromARGB(255, 208, 62, 62))),
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
              child: Padding(padding: EdgeInsets.all(10), child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        tappedId == id
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: tappedId == id ? Colors.green : Colors.grey,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Review PR #42", style: TextStyle(fontSize: 16, color: Colors.black)),
                          SizedBox(height: 5),
                          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            
                            
                            Container(
                              decoration: BoxDecoration(
                                color: newColor,
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6), child: Text("Work", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: clr,)),),),
                              SizedBox(width: 10),
                            

                          Text("19 May 2026", style: TextStyle(fontSize: 11, color: Color(0xFF888780))),
                           
                          ]),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              )
            ),
          ),
        ),
      ),
    );
    // );
  }
}
