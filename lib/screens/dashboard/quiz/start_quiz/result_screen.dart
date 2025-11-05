import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/app_assets_image.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../../../../res/routes/routes_name.dart';

class ResultScreen extends StatelessWidget {
  final String score; // e.g. "50%"
  final bool passed; // e.g. true
  final int totalQuestions;
  final int correctAnswers;

  const ResultScreen({
    super.key,
    required this.score,
    required this.passed,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    bool done = passed; // reuse your variable name for readability

    return WillPopScope(
      onWillPop: () async => false,
      child: BackgroundWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Quiz Result",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.black121,
              ),
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
                      color: const Color(0xFF9C9DF2),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: done ? _buildSuccessView(score) : _buildFailView(score),
                  ),
                ),
                SizedBox(height: 30.h),
                GradientButtonWidget(
                  title: done ? "Continue" : "Done",
                  onTap: () {
                    Get.offAllNamed(RouteName.dashboardScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessView(String score) {
    return Column(
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
          '$score Score',
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
      ],
    );
  }

  Widget _buildFailView(String score) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAssetsImage(
          imagePath: ImageAssets.warning,
          fit: BoxFit.scaleDown,
          width: 180.w,
          height: 150.h,
        ),
        Text(
          'Oops!',
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          '$score Score',
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
          "Try Again Tomorrow",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, color: AppColor.redColor, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
