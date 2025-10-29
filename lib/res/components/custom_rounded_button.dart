import 'package:balochi_tutor/res/components/round_button.dart';
import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../colors/app_color.dart';
import 'custom_text.dart';

class CustomRoundButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final List<BoxShadow>? boxShadow;
  final bool isLoading;
  final Color buttonColor;
  final Color? textColor;

  const CustomRoundButton({
    super.key,
    this.title,
    this.onPress,
    this.height,
    this.width,
    this.fontSize,
    this.boxShadow,
    this.fontWeight,
    this.buttonColor = AppColor.primaryColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RoundButton(
          buttonColor: buttonColor,
          text: isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    color: AppColor.primaryTextColor,
                    strokeWidth: 2.5,
                  ),
                )
              : CustomText(
                  title: title ?? '',
                  fontcolor: textColor ?? AppColor.primaryTextColor,
                  textalign: TextAlign.center,
                  fontsize: fontSize ?? 16.sp,
                  fontweight: fontWeight ?? FontWeight.bold,
                ),
          onPress: isLoading ? null : onPress,
          height: height ??
              (context.orientation == Orientation.portrait
                  ? context.blockSizeVertical * 7
                  : context.blockSizeHorizontal * 7),
          width: width ?? context.blockSizeHorizontal * 85,
          boxshadow: boxShadow ??
              [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
        ),
      ),
    );
  }
}
