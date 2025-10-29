import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../colors/app_color.dart';
import '../custom_rounded_button.dart';
import '../custom_text.dart';

class ProfileDialogBox extends StatelessWidget {
  final String text;
  final String continueButton;
  final String? hideText;
  final Function() onTap;
  final Color? backgroundColor;
  final Widget? title;
  final double? heightFactor;

  const ProfileDialogBox({
    super.key,
    required this.text,
    required this.onTap,
    required this.continueButton,
    this.backgroundColor,
    this.hideText,
    this.heightFactor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.all(20),
      title: title ??
          Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor,
              ),
              child: Icon(Icons.question_mark_outlined, color: AppColor.whiteColor, size: 20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            title: text,
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.center,
            fontsize: 14.sp,
          ),
          SizedBox(
            height: 20.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomRoundButton(
                    buttonColor: AppColor.whiteColor,
                    textColor: AppColor.primaryColor,
                    title: "Cancel",
                    fontSize: 12.sp,
                    height: 35.sp,
                    onPress: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomRoundButton(
                    title: continueButton,
                    fontSize: 12.sp,
                    height: 35.sp,
                    onPress: onTap,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
