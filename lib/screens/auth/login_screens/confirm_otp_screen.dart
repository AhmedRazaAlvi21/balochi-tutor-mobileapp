import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/registration_controller/registartion_controller.dart';
import '../../../main.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/custom_text_button.dart';
import '../../../res/components/otp_fields.dart';
import '../../../utils/utils.dart';

class ConfirmOtpScreen extends StatelessWidget {
  const ConfirmOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    registerController.initOtpController(Get.arguments as Map<String, dynamic>?, context);

    return WillPopScope(
      onWillPop: () async => Utils.onwillPopFunc(context),
      child: BackgroundWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      title: 'otp_page_text'.tr,
                      fontcolor: AppColor.blackColor,
                      fontsize: 24.sp,
                      fontweight: FontWeight.w700,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomText(
                      title: 'otp_page_text2'.tr,
                      fontcolor: AppColor.blackColor,
                      fontweight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: context.blockSizeVertical * 3),
                CustomOTPField(
                  fieldCount: 4,
                  fieldWidth: context.blockSizeHorizontal * 20,
                  fieldHeight: context.orientation == Orientation.portrait
                      ? context.blockSizeVertical * 7
                      : context.blockSizeHorizontal * 7,
                  borderWidth: 1.0,
                  borderColor: Colors.transparent,
                  focusedBorderColor: AppColor.primaryColor,
                  backgroundColor: AppColor.whiteColor,
                  textColor: AppColor.blackColor,
                  borderRadius: 16.0,
                  onChanged: (value) {
                    registerController.otpValue.value = value;
                  },
                ),
                SizedBox(height: context.blockSizeVertical * 3),
                Obx(() => registerController.countdown.value > 0
                    ? RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: "You can resend code in ", style: TextStyle(color: Colors.black)),
                            TextSpan(
                              text: "${registerController.countdown.value} ",
                              style: TextStyle(color: AppColor.primaryColor),
                            ),
                            const TextSpan(text: "s.", style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: 'otp_page_text3'.tr,
                            fontcolor: AppColor.blackColor,
                            fontweight: FontWeight.w400,
                          ),
                          CustomTextButton(
                            text: "Resend OTP",
                            onPressed: () => registerController.startCountdown(true, context),
                            fontsize: 12.sp,
                            fontweight: FontWeight.w500,
                            fontcolor: AppColor.redColor,
                          ),
                        ],
                      )),
                SizedBox(height: context.blockSizeVertical * 10),
                Obx(() {
                  return registerController.otpValue.value.length == 4
                      ? CustomRoundButton(
                          title: loadingController.isLoading.value ? null : 'continue'.tr,
                          isLoading: loadingController.isLoading.value,
                          onPress: loadingController.isLoading.value
                              ? null
                              : () => registerController.verifyOtp(context, loadingController.isLoading),
                        )
                      : const SizedBox();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
