import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await Utils.onwillPopFunc(context);
      },
      child: BackgroundWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppAssetsImage(
                        imagePath: ImageAssets.balochiLogo,
                        fit: BoxFit.scaleDown,
                        width: 190.w,
                        height: 190.h,
                      ),
                      CustomText(title: "Balochi", fontsize: 48.sp, fontweight: FontWeight.w700),
                      CustomText(title: "Tutor", fontsize: 24.sp, fontweight: FontWeight.w700),
                    ],
                  ),
                ),
                CustomRoundButton(
                    title: 'GET STARTED',
                    isLoading: false,
                    onPress: () {
                      Get.toNamed(RouteName.registerNameScreen);
                    }),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteName.signInScreen);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: context.blockSizeHorizontal * 85,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColor.whiteColor1),
                    child: Center(
                      child: CustomText(
                        title: 'I ALREADY HAVE AN ACCOUNT'.tr,
                        fontsize: 14,
                        fontweight: FontWeight.w600,
                        fontcolor: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.blockSizeVertical * 7,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
