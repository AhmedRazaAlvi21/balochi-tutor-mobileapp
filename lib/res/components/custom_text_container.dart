import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_color.dart';
import 'custom_text.dart';

class CustomTextContainer extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? boxBorder;
  final double? fontSize;
  final Function()? onTap;
  final bool isLoading;

  CustomTextContainer(
      {required this.title,
      this.backgroundColor,
      this.margin,
      this.padding,
      this.borderRadius,
      this.boxBorder,
      this.textColor,
      this.fontSize,
      this.onTap,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap ?? () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 15.0,
            ),
        decoration: BoxDecoration(
          color: backgroundColor ?? Color(0xFFFAFAFA),
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          border: boxBorder ??
              Border.all(
                color: Colors.grey.shade500,
                width: 1.0,
              ),
          gradient: backgroundColor == null
              ? LinearGradient(
                  colors: AppColor.appPrimaryGradient1,
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                )
              : null,
        ),
        child: isLoading
            ? SizedBox(
                width: 18.w,
                height: 18.h,
                child: CircularProgressIndicator(
                  color: AppColor.primaryTextColor,
                  strokeWidth: 2.5,
                ),
              )
            : CustomText(
                title: title,
                textalign: TextAlign.center,
                fontcolor: textColor ?? AppColor.secondaryTextColor,
                fontsize: fontSize ?? 20,
                fontweight: FontWeight.w700,
              ),
      ),
    );
  }
}
