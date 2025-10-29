import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/app_color.dart';

class ShowToast {
  showToast(BuildContext context, String? message, {bool error = false, Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      backgroundColor: error ? AppColor.redColor : backgroundColor,
    ));
  }

  showFlushBar(BuildContext context,
      {required String message,
      bool error = false,
      bool showUndo = false,
      bool showMainButton = true,
      int durationSecond = 3,
      FlushbarPosition? flushbarPosition}) {
    return Flushbar(
      shouldIconPulse: false,
      message: message,
      duration: Duration(seconds: durationSecond),
      animationDuration: Duration(milliseconds: 500),
      isDismissible: true,
      messageColor: AppColor.blackColor,
      backgroundColor: AppColor.whiteColor,
      mainButton: showMainButton
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: IntrinsicHeight(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: error ? AppColor.redColor : AppColor.greenColor1,
                  ),
                ),
              ),
            )
          : SizedBox(),
      flushbarPosition: flushbarPosition ?? FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8.sp),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(15.sp),
      leftBarIndicatorColor: error ? AppColor.redColor : AppColor.greenColor1,
    ).show(context);
  }
}
