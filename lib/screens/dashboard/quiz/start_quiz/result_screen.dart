import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/app_assets_image.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../../../../res/routes/routes_name.dart';
import '../../../../utils/utils.dart';

class ResultScreen extends StatelessWidget {
  final bool done;
  final int totalQuestions;
  final int correctAnswers;

  const ResultScreen({super.key, required this.totalQuestions, required this.correctAnswers, required this.done});

  @override
  Widget build(BuildContext context) {
    double scorePercentage = (correctAnswers / totalQuestions) * 100;

    return WillPopScope(
      onWillPop: () async {
        return Utils.onwillPopFunc(context);
      },
      child: BackgroundWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Quiz Result",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: AppColor.black121),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Color(0xFF9C9DF2),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: done
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppAssetsImage(
                                  imagePath: ImageAssets.cup,
                                  fit: BoxFit.scaleDown,
                                  width: 180.w,
                                  height: 150.h,
                                ),
                                Text(
                                  'Congrats!',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  '${scorePercentage.toStringAsFixed(0)}% Score',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: AppColor.greenF3A,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Quiz Completed Successfully',
                                  style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'You attempted $totalQuestions questions\nAnd from that $correctAnswers is correct.\n$correctAnswers/$totalQuestions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppAssetsImage(
                                  imagePath: ImageAssets.warning,
                                  fit: BoxFit.scaleDown,
                                  width: 180.w,
                                  height: 150.h,
                                ),
                                Text(
                                  'opps!',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  '${scorePercentage.toStringAsFixed(0)}% Score',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: AppColor.redColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Quiz Section Failed",
                                  style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'You attempted $totalQuestions questions\nAnd from that $correctAnswers is correct.\n$correctAnswers/$totalQuestions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Try Again Tomorrow",
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontSize: 20.sp, color: AppColor.redColor, fontWeight: FontWeight.w700),
                                )
                              ],
                            )),
                ),
                SizedBox(height: 30.h),
                GradientButtonWidget(
                  title: done ? "Continue" : "Done",
                  onTap: () {
                    Get.toNamed(RouteName.dashboardScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
