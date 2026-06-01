import 'package:flutter/material.dart';

Future<void> confirmDialog(
  BuildContext context,
  String title,
  String content,
  Function onOk,
  Function onCancel,
) {
  double width = MediaQuery.of(context).size.width;
  double buttonWidth = width * 0.25;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFF5F3EE),
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    side: WidgetStateProperty.all(
                      BorderSide(color: Color(0xFFD3D1C7)),
                    ),
                  ),
                  child: SizedBox(
                    width: buttonWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  onPressed: () async {
                    onOk();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  child: SizedBox(
                    width: buttonWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
