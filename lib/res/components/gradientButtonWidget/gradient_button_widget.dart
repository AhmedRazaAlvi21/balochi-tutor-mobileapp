import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/app_color.dart';

class GradientButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  final double? width;
  final EdgeInsets? padding;

  const GradientButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 195.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: AppColor.gradientButton, begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
