import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_check_box.dart';
import '../../../res/components/custom_form_field.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/routes/routes_name.dart';
import '../../../service/auth_service/reset_password_service.dart';
import '../../../utils/utils.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

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
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'new_password_page_text'.tr,
                          fontcolor: AppColor.blackColor,
                          fontsize: 22.sp,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'new_password_page_text2'.tr,
                          fontcolor: AppColor.blackColor,
                          fontsize: 14.sp,
                          fontweight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: context.blockSizeVertical * 4,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'new_password_page_text3'.tr,
                          fontcolor: AppColor.blackColor,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                      Obx(
                        () => CustomFormField(
                          title: '',
                          onchange: (val) {
                            final newPass = forgetPasswordController.newPasswordController.text.trim();
                            final confirmPass = forgetPasswordController.confirmPasswordController.text.trim();

                            final isValid = forgetPasswordController.validatePassword(newPass);
                            final isMatch = newPass.isNotEmpty && confirmPass.isNotEmpty && newPass == confirmPass;

                            forgetPasswordController.newPasswordValidate.value = isValid && isMatch;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "required";
                            }
                            if (!forgetPasswordController.validatePassword(val.toString())) {
                              return "Password must contains at least\n• 1 Uppercase letter\n• 1 Digit\n• 1 Special character";
                            }
                            if (val.length < 8) {
                              return "Password must be at least 8 characters long";
                            }
                          },
                          ispassword: forgetPasswordController.NewPasswordVisibility.value,
                          sIcon: InkWell(
                            onTap: () {
                              forgetPasswordController.NewPasswordVisibility.toggle();
                            },
                            child: Icon(
                              !forgetPasswordController.NewPasswordVisibility.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          fieldcontroller: forgetPasswordController.newPasswordController,
                        ),
                      ),
                      SizedBox(
                        height: context.blockSizeVertical * 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'new_password_page_text4'.tr,
                          fontcolor: AppColor.blackColor,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                      Obx(
                        () => CustomFormField(
                          title: '',
                          // focusnode: controller.nameFocusNode,
                          ispassword: forgetPasswordController.ConfirmPasswordVisibility.value,
                          sIcon: InkWell(
                            onTap: () {
                              forgetPasswordController.ConfirmPasswordVisibility.toggle();
                            },
                            child: Icon(
                              !forgetPasswordController.ConfirmPasswordVisibility.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          onchange: (val) {
                            final newPass = forgetPasswordController.newPasswordController.text.trim();
                            final confirmPass = forgetPasswordController.confirmPasswordController.text.trim();

                            final isValid = forgetPasswordController.validatePassword(newPass);
                            final isMatch = newPass.isNotEmpty && confirmPass.isNotEmpty && newPass == confirmPass;

                            forgetPasswordController.newPasswordValidate.value = isValid && isMatch;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "required";
                            }
                            if (val != forgetPasswordController.newPasswordController.text) {
                              return "Both passwords does not match";
                            }
                          },
                          fieldcontroller: forgetPasswordController.confirmPasswordController,
                        ),
                      ),
                      Obx(() {
                        return forgetPasswordController.newPasswordValidate.value
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Obx(
                                    () => CustomCheckBox(
                                      isChecked: forgetPasswordController.rememberMe.value,
                                      onChanged: (val) {
                                        forgetPasswordController.rememberMe.value = val!;
                                      },
                                      title: 'remember_me'.tr,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox();
                      }),
                    ],
                  ),
                ),
              )),
              Obx(() {
                return forgetPasswordController.newPasswordValidate.value
                    ? Column(
                        children: [
                          CustomRoundButton(
                            title: loadingController.isLoading.value ? null : 'Continue'.tr,
                            isLoading: loadingController.isLoading.value,
                            onPress: loadingController.isLoading.value
                                ? null
                                : () async {
                                    loadingController.setLoading(true);
                                    try {
                                      var response = await ResetPasswordService().callResetPasswordService(context);
                                      if ((response.responseData?.success != false &&
                                              response.responseData?.code == 200) ||
                                          response.responseData?.code == 201) {
                                        Utils.toastMessage(context, "${response.responseData?.message}", true);
                                        Future.delayed(const Duration(seconds: 2), () {
                                          Get.toNamed(RouteName.loginScreen);
                                        });
                                      } else if (response.responseData?.success == false) {
                                        Utils.toastMessage(context, "${response.responseData?.message}", false);
                                      } else {
                                        Utils.toastMessage(context, "Reset Password failed.Please try again.", false);
                                      }
                                    } catch (error) {
                                      Utils.toastMessage(context, "An error occurred: $error", false);
                                    } finally {
                                      loadingController.setLoading(false);
                                    }
                                  },
                          ),
                        ],
                      )
                    : const SizedBox.shrink();
              }),
              SizedBox(
                height: context.blockSizeVertical * 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
