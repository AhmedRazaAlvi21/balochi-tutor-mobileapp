import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../colors/app_color.dart';
import 'custom_text.dart';

Future<Future<String?>> customConfirmationDiaglog(
    BuildContext context, String dialog_txt, String confirm_txt, String cancel_txt, void Function()? onConfirm) async {
  var vertical = context.orientation == Orientation.portrait ? context.blockSizeVertical : context.blockSizeHorizontal;
  var horizontal = context.blockSizeHorizontal;
  return showDialog<String>(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
      elevation: 10,
      insetPadding: EdgeInsets.symmetric(horizontal: 60),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 25.0),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: vertical * 6,
            // ),
            Container(
              // width: horizontal * 65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              child: CustomText(
                title: dialog_txt,
                fontcolor: AppColor.whiteColor,
                textalign: TextAlign.center,
                fontsize: 16.sp,
                fontweight: FontWeight.w600,
              ),
            ),
            // SizedBox(
            //   height: vertical * 5,
            // ),
            // const Divider(
            //   thickness: 1,

            //   color: AppColor.blackColor,
            // ),

            InkWell(
              onTap: onConfirm,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 17),
                alignment: Alignment.center,
                child: CustomText(
                  title: confirm_txt,
                  fontcolor: AppColor.blackColor,
                  fontsize: 16.sp,
                  fontweight: FontWeight.w700,
                ),
              ),
            ), // Button(
            //   title: confirm_txt,
            //   backcolor: Color(0xFF635887),
            //   txtColor: Colors.white,
            //   padding: 14,
            //   function: onConfirm,
            // ),
            const Divider(
              thickness: 1,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                alignment: Alignment.center,
                child: CustomText(
                  title: cancel_txt,
                  fontcolor: AppColor.redColor,
                  fontsize: 16.sp,
                  fontweight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
