import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_form_field.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/routes/routes_name.dart';
import '../../../service/auth_service/forget_password_services.dart';
import '../../../utils/utils.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      // painter: LanguageLearningBackgroundPainter(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          // elevation: 0.0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppAssetsImage(
                imagePath: ImageAssets.balochiLogo,
                fit: BoxFit.scaleDown,
                width: 190.w,
                height: 190.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomText(
                    title: 'forgot_password_page_text'.tr,
                    fontcolor: AppColor.blackColor,
                    fontsize: 24.sp,
                    fontweight: FontWeight.w700,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: CustomText(
                    title: 'forgot_password_get_otp'.tr,
                    fontcolor: AppColor.blackColor,
                    fontweight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: context.blockSizeVertical * 3,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: CustomText(
                    title: 'email'.tr,
                    fontcolor: AppColor.blackColor,
                    fontweight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: CustomFormField(
                  title: '',
                  onchange: (val) {
                    if (val.toString().isNotEmpty && forgetPasswordController.emailRegex.hasMatch(val)) {
                      forgetPasswordController.fEmailValidate.value = true;
                    } else {
                      forgetPasswordController.fEmailValidate.value = false;
                    }
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "required";
                    }
                    if (!forgetPasswordController.emailRegex.hasMatch(val)) {
                      return "Invalid email address";
                    }
                  },
                  // focusnode: controller.nameFocusNode,
                  fieldcontroller: forgetPasswordController.forgotEmailController,
                ),
              ),
              SizedBox(
                height: context.orientation == Orientation.portrait
                    ? context.blockSizeVertical * 17
                    : context.blockSizeHorizontal * 10,
              ),
              Obx(
                () => !forgetPasswordController.fEmailValidate.value
                    ? Center()
                    : CustomRoundButton(
                        title: 'continue'.tr,
                        isLoading: false,
                        onPress: loadingController.isLoading.value
                            ? null
                            : () async {
                                loadingController.setLoading(true);
                                try {
                                  final response = await ForgetPasswordServices().callForgetPasswordServices(context);
                                  if (response.responseData?.code == 200 || response.responseData?.code == 201) {
                                    Utils.toastMessage(context, "${response.responseData?.message}", true);
                                    Future.delayed(const Duration(seconds: 2), () {
                                      Get.toNamed(RouteName.confirmOtpScreen, arguments: {'isForget': true});
                                    });
                                  } else if (response.responseData?.success == false) {
                                    Utils.toastMessage(context, "${response.responseData?.message}", false);
                                  } else {
                                    Utils.toastMessage(context, "Forget Password failed. Please try again.", false);
                                  }
                                } catch (error) {
                                  Utils.toastMessage(context, "An error occurred: $error", false);
                                } finally {
                                  loadingController.setLoading(false);
                                }
                              },
                      ),
              ),
              SizedBox(
                height: context.blockSizeVertical * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
