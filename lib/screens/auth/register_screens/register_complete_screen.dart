import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/assets/custom_bubble_shape.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';

class RegisterCompleteScreen extends StatefulWidget {
  const RegisterCompleteScreen({super.key});

  @override
  State<RegisterCompleteScreen> createState() => _RegisterCompleteScreenState();
}

class _RegisterCompleteScreenState extends State<RegisterCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Utils.onwillPopFunc(context);
      },
      child: BackgroundWidget(
        // painter: LanguageLearningBackgroundPainter(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.blockSizeVertical * 20,
                ),
                CustomPaint(
                  painter: RPSCustomPainter(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                      right: 50.0,
                      left: 50.0,
                      top: 5.0,
                    ),
                    child: CustomText(
                      title: 'hurray'.tr,
                      fontcolor: AppColor.blackColor,
                      fontsize: 20,
                      fontweight: FontWeight.w700,
                    ),
                  ),
                ),
                AppAssetsImage(
                  imagePath: ImageAssets.excite,
                  fit: BoxFit.scaleDown,
                  width: 200.w,
                  height: 240.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5.0,
                  ),
                  child: CustomText(
                    title: 'welcome'.tr,
                    fontcolor: AppColor.primaryColor,
                    textalign: TextAlign.center,
                    fontsize: 46,
                    fontweight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: CustomText(
                    title: 'profile_created'.tr,
                    fontcolor: AppColor.greyColor,
                    textalign: TextAlign.center,
                    fontsize: 20,
                    fontweight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                CustomRoundButton(
                  title: 'continue'.tr,
                  onPress: () {
                    Get.toNamed(RouteName.signInScreen);
                  },
                ),
                SizedBox(
                  height: context.orientation == Orientation.portrait
                      ? context.blockSizeVertical * 3
                      : context.blockSizeHorizontal * 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
