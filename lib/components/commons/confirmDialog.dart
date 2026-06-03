import 'package:birdle/storage/theme_storage.dart';
import 'package:birdle/utils/constants/colors.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      return Consumer(
        builder: (context, ref, child) {
          final appTheme = ref.watch(currentTheme).value ?? '';
          return AlertDialog(
            backgroundColor: TColors.background(appTheme),
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
                      style: TButtonTheme.secondaryTextButton(appTheme),
                      child: SizedBox(
                        width: buttonWidth,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: TColors.text(appTheme),
                                fontSize: 16,
                              ),
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
                      style: TButtonTheme.primaryTextButton(appTheme),
                      child: SizedBox(
                        width: buttonWidth,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: Text(
                              "OK",
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
            ],
          );
        },
      );
    },
  );
}
