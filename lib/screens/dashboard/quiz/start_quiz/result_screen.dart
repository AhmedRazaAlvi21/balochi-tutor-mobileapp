import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_controller/profile_controller.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/app_assets_image.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../../../../res/routes/routes_name.dart';

class ResultScreen extends StatelessWidget {
  final String score; // e.g. "50%"
  final bool passed;
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
    final ProfileController profileController = Get.find<ProfileController>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
      child: BackgroundWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(),
          body: Obx(() {
            // Show loading indicator when dashboard data is being refreshed
            if (profileController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ResultCard(
                      passed: passed,
                      score: score,
                      totalQuestions: totalQuestions,
                      correctAnswers: correctAnswers,
                    ),
                    SizedBox(height: 30.h),
                    SafeArea(
                      child: GradientButtonWidget(
                        title: passed ? "Done" : "Continue",
                        onTap: () => Get.offAllNamed(RouteName.dashboardScreen),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// --- App Bar ---
  AppBar _buildAppBar() => AppBar(
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
      );
}

/// --- Result Card Widget ---
class _ResultCard extends StatelessWidget {
  final bool passed;
  final String score;
  final int totalQuestions;
  final int correctAnswers;

  const _ResultCard({
    required this.passed,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
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
      child: passed ? _buildSuccess() : _buildFailure(),
    );
  }

  /// --- Success Layout ---
  Widget _buildSuccess() => _buildResultContent(
        image: ImageAssets.cup,
        title: 'Congrats!',
        titleColor: Colors.white,
        scoreColor: AppColor.greenF3A,
        subtitle: 'Quiz Completed Successfully',
        bottomText: 'Try Again Tomorrow',
      );

  /// --- Failure Layout ---
  Widget _buildFailure() => _buildResultContent(
        image: ImageAssets.warning,
        title: 'Oops!',
        titleColor: Colors.white,
        scoreColor: AppColor.redColor,
        subtitle: 'Quiz Section Failed',
        bottomText: 'Try Again Tomorrow',
      );

  /// --- Shared UI for success/failure ---
  Widget _buildResultContent({
    required String image,
    required String title,
    required Color titleColor,
    required Color scoreColor,
    required String subtitle,
    required String bottomText,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAssetsImage(
          imagePath: image,
          fit: BoxFit.scaleDown,
          width: 180.w,
          height: 150.h,
        ),
        SizedBox(height: 10.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 33.sp,
            color: titleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          '$score% Score',
          style: TextStyle(
            fontSize: 42.sp,
            color: scoreColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          'You attempted $totalQuestions questions\nand got $correctAnswers correct.',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          '$correctAnswers / $totalQuestions',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!passed) ...[
          SizedBox(height: 10.h),
          Text(
            bottomText,
            style: TextStyle(
              fontSize: 20.sp,
              color: scoreColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
