import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_color.dart';
import 'custom_text.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool isChecked;
  final Function(bool?)? onChanged;

  CustomCheckBox({required this.isChecked, required this.onChanged, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: Color(0xFF6949FF),
              width: 2.0,
            ),
          ),
          value: isChecked,
          onChanged: onChanged,
          checkColor: Colors.white,
          activeColor: Color(0xFF6949FF),
          side: BorderSide(
            color: Color(0xFF6949FF),
            width: 2.5,
          ),
        ),
        CustomText(
          title: title,
          fontcolor: AppColor.blackColor,
          textalign: TextAlign.center,
          fontsize: 14.sp,
          fontweight: FontWeight.w500,
        ),
      ],
    );
  }
}
