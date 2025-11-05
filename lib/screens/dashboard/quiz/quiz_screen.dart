import 'package:balochi_tutor/screens/dashboard/quiz/start_quiz/start_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/quiz_controller/quiz_controller.dart';
import '../../../res/assets/custom_bubble_shape.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../../../res/components/gradientButtonWidget/gradient_text_widget.dart';

class QuizScreen extends StatelessWidget {
  final int quizId;

  QuizScreen({super.key, required this.quizId});

  final QuizController controller = Get.put(QuizController());

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
            SizedBox(height: 20.h),
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

            /// Dropdown
            Obx(() => Container(
                  width: 195.w,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColor.gradientButton,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFFEDE8FF),
                      borderRadius: BorderRadius.circular(16.r),
                      value: controller.selectedType.value.isEmpty ? null : controller.selectedType.value,
                      hint: Text(
                        "Select Quiz Type",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      items: controller.quizTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: AppColor.gradientButton,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.setQuizType(value!);
                      },
                    ),
                  ),
                )),

            SizedBox(height: 5.h),
            Obx(() {
              if (controller.selectedType.value.isNotEmpty) {
                return GradientButtonWidget(
                  title: "Start Quiz",
                  onTap: () {
                    Get.to(() => StartQuiz(
                          quizId: quizId,
                          selectedType: controller.selectedType.value,
                        ));
                  },
                );
              } else {
                return SizedBox();
              }
            }),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
