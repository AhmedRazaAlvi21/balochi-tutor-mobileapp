import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_form_field.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/rounded_linear_progress_bar.dart';
import '../../../res/routes/routes_name.dart';
import '../../../service/auth_service/signup_service.dart';
import '../../../utils/utils.dart';
import '../widget/profile_image_edit_widget.dart';

class RegisterPasswordScreen extends StatelessWidget {
  const RegisterPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RoundedLinearProgressIndicator(
              value: 1.0,
              backgroundColor: Color(0xffEEEEEE),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: registerController.formkey,
                    child: Column(
                      children: [
                        ProfileImageEditWidget(controller: registerController),
                        SizedBox(height: 20.h),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: 'password_screen_text'.tr,
                            fontcolor: AppColor.blackColor,
                            fontsize: 26.sp,
                            fontweight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: 'password'.tr,
                            fontcolor: AppColor.blackColor,
                            fontweight: FontWeight.w700,
                          ),
                        ),
                        Obx(
                          () => CustomFormField(
                            title: '',
                            ispassword: registerController.showPassword.value,
                            sIcon: InkWell(
                              onTap: () {
                                registerController.showPassword.toggle();
                              },
                              child: Icon(
                                !registerController.showPassword.value ? Icons.visibility : Icons.visibility_off,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            onchange: (val) {
                              if (registerController.formkey.currentState!.validate() &&
                                  registerController.validatePassword(val.toString())) {
                                registerController.passwordValidate.value = true;
                              } else {
                                registerController.passwordValidate.value = false;
                              }
                            },
                            validator: (val) {
                              if (val.isEmpty) return "required";
                              if (!registerController.validatePassword(val.toString())) {
                                return "Password must contain at least\n• 1 Uppercase letter\n• 1 Digit";
                              }
                              if (val.length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                            },
                            fieldcontroller: registerController.passwordController,
                          ),
                        ),
                        SizedBox(height: context.blockSizeVertical * 2),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: 'confirm'.tr + ' ' + 'password'.tr,
                            fontcolor: AppColor.blackColor,
                            fontweight: FontWeight.w700,
                          ),
                        ),
                        Obx(
                          () => CustomFormField(
                            title: '',
                            ispassword: registerController.confirmShowPassword.value,
                            sIcon: InkWell(
                              onTap: () {
                                registerController.confirmShowPassword.toggle();
                              },
                              child: Icon(
                                !registerController.confirmShowPassword.value ? Icons.visibility : Icons.visibility_off,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            onchange: (val) {
                              if (registerController.formkey.currentState!.validate()) {
                                registerController.passwordValidate.value = true;
                              } else {
                                registerController.passwordValidate.value = false;
                              }
                            },
                            validator: (val) {
                              if (val.isEmpty) return "required";
                              if (val != registerController.passwordController.text) {
                                return "Both passwords do not match";
                              }
                            },
                            fieldcontroller: registerController.confirmPasswordController,
                          ),
                        ),
                        SizedBox(height: context.blockSizeHorizontal * 5),
                        // CustomRoundButton(
                        //   title: 'continue'.tr,
                        //   isLoading: false,
                        //   onPress: () {
                        //     if (registerController.formkey.currentState!.validate()) {
                        //       final password = registerController.passwordController.text.trim();
                        //       final confirmPassword = registerController.confirmPasswordController.text.trim();
                        //       log('Selected Image Path: ${registerController.profilePicturePath.value}');
                        //       log('Entered Name: ${registerController.nameController.text}');
                        //       log('Entered age: ${registerController.ageController.text}');
                        //       log('Entered email: ${registerController.emailController.text}');
                        //       log('Entered password: $password');
                        //       log('Entered confirmPassword: $confirmPassword');
                        //       Get.toNamed(RouteName.registerCompleteScreen);
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => registerController.passwordValidate.value
                ? CustomRoundButton(
                    title: loadingController.isLoading.value ? null : 'continue'.tr,
                    isLoading: loadingController.isLoading.value,
                    onPress: loadingController.isLoading.value
                        ? null
                        : () async {
                            loadingController.setLoading(true);
                            try {
                              final response = await SignupService().callSignupService(context, true);
                              if (response.responseData?.code == 200 || response.responseData?.code == 201) {
                                Utils.toastMessage(context, "${response.responseData?.message}", true);
                                Future.delayed(const Duration(seconds: 2), () {
                                  Get.toNamed(RouteName.confirmOtpScreen, arguments: {'isForget': false});
                                });
                              } else if (response.responseData?.error != null) {
                                Utils.toastMessage(context, "${response.responseData?.error}", false);
                              } else {
                                Utils.toastMessage(context, "Something went wrong", false);
                              }
                            } catch (error) {
                              Utils.toastMessage(context, "An error occurred: $error", false);
                              print("Error during signup: $error");
                            } finally {
                              loadingController.setLoading(false);
                            }
                          },
                  )
                : Center()),
            SizedBox(height: context.blockSizeVertical * 3),
          ],
        ),
      ),
    );
  }
}
