import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? body;
  final List<Widget>? actions;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  const CustomAlertDialog(
      {super.key, this.title, this.body, this.borderRadius, this.backgroundColor, this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(25.0),
      ),
      title: title,
      content: body,
      actions: actions,
    );
  }
}
