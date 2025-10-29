import 'package:flutter/material.dart';

import '../colors/app_color.dart';
import 'custom_text.dart';

class ButtonWithIcon extends StatelessWidget {
  final String title;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget icon;
  final VoidCallback onpress;

  const ButtonWithIcon(
      {super.key,
      required this.title,
      this.borderColor = Colors.transparent,
      this.backgroundColor = AppColor.primaryColor,
      this.textColor = AppColor.whiteColor,
      required this.icon,
      this.borderWidth = 0,
      required this.onpress,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: context.blockSizeHorizontal * 45,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(25.0),
            side: BorderSide(color: borderColor!, width: borderWidth!),
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: onpress,
        icon: icon,
        label: CustomText(
          title: title,
          fontsize: 16,
          fontcolor: textColor!,
          fontweight: FontWeight.w700,
        ),
      ),
    );
  }
}
