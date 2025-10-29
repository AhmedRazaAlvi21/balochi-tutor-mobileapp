import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../main.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/custom_text_button.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, String>> socialLogins = [
    //   {'title': 'Continue with Facebook', 'imagePath': ImageAssets.facebook_svg},
    //   {'title': 'Continue with Google', 'imagePath': ImageAssets.google_svg},
    // ];
    //
    // if (Platform.isIOS) {
    //   socialLogins.add({'title': 'Continue with Apple', 'imagePath': ImageAssets.apple_svg});
    // }
    return WillPopScope(
      onWillPop: () async {
        return Utils.onwillPopFunc(context);
      },
      child: BackgroundWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // leading: InkWell(
            //   onTap: () {
            //     Get.back();
            //   },
            //   child: const Icon(Icons.arrow_back),
            // ),
          ),
          body: SingleChildScrollView(
            child: Obx(
              () => Skeletonizer(
                enabled: loginController.onSignInLoading.value,
                child: Column(
                  children: [
                    AppAssetsImage(
                      imagePath: ImageAssets.balochiLogo,
                      fit: BoxFit.scaleDown,
                      width: 180.w,
                      height: 180.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: CustomText(
                          title: "Let’s you in",
                          fontcolor: AppColor.blackColor,
                          fontsize: 32.sp,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        loginController.googleAuth(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        width: context.blockSizeHorizontal * 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: AppColor.whiteColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppAssetsImage(
                              imagePath: ImageAssets.google_logo,
                              fit: BoxFit.scaleDown,
                              width: 30.w,
                              height: 30.h,
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              title: 'Continue with Google',
                              fontsize: 16,
                              fontweight: FontWeight.w600,
                              fontcolor: AppColor.blackColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomText(
                      title: "or",
                      fontcolor: AppColor.blackColor,
                      fontweight: FontWeight.w700,
                    ),
                    const SizedBox(height: 40),
                    CustomRoundButton(
                      title: 'Sign in with password',
                      fontWeight: FontWeight.w700,
                      onPress: () {
                        Get.toNamed(RouteName.loginScreen);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: 'dont_have_account'.tr,
                            fontcolor: AppColor.greyColor,
                            fontsize: 14.sp,
                            fontweight: FontWeight.w500,
                          ),
                          CustomTextButton(
                            text: 'sign_up'.tr,
                            onPressed: () {
                              print("click on sign Up screen");
                              Get.toNamed(RouteName.signUpScreen);
                            },
                            fontsize: 14.sp,
                            fontweight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
