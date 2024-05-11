import 'package:flutter/material.dart';

class CustomDialog {
  static Future<void> dialogBuilder(BuildContext context, Widget widget) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
