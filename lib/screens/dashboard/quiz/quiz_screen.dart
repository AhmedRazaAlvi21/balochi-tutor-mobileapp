import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/assets/custom_bubble_shape.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../../../res/components/gradientButtonWidget/gradient_text_widget.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            GradientTextWidget(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Text(
                "Quiz",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF5F4AE0),
                ),
              ),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  right: 40,
                  child: CustomPaint(
                    painter: RPSCustomPainter(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 25.0,
                        right: 15.0,
                        left: 15.0,
                        top: 10.0,
                      ),
                      child: CustomText(
                        title: "Have a Nice Quiz!",
                        fontcolor: AppColor.blackColor,
                        fontsize: 16.sp,
                        fontweight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 350,
                  //color: Colors.grey,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40.w),
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      AppAssetsImage(
                        imagePath: ImageAssets.character,
                        fit: BoxFit.contain,
                        height: 220.h,
                        width: 220.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            GradientButtonWidget(
              title: "Started",
              onTap: () {
                Get.toNamed(RouteName.startQuiz);
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
