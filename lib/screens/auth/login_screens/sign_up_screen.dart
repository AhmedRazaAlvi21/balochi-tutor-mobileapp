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
import '../../../res/components/custom_check_box.dart';
import '../../../res/components/custom_form_field.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/custom_text_button.dart';
import '../../../res/routes/routes_name.dart';
import '../../../service/auth_service/signup_service.dart';
import '../../../utils/utils.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
              child: Obx(
                () => Skeletonizer(
                  enabled: loginController.onSignUpLoading.value,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppAssetsImage(
                          imagePath: ImageAssets.balochiLogo,
                          fit: BoxFit.scaleDown,
                          width: 180.w,
                          height: 180.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomText(
                            title: "Create Your Account",
                            fontcolor: AppColor.blackColor,
                            fontsize: 28.sp,
                            fontweight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: context.blockSizeVertical * 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: CustomFormField(
                            hintStyle: TextStyle(fontSize: 13.sp, color: AppColor.greyColor1),
                            isFilled: true,
                            fontsize: 16.sp,
                            fontColor: AppColor.blackColor,
                            bgColor: AppColor.whiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            title: 'Name',
                            onchange: (val) {
                              // Update validation based on name, email, and password
                              if (val.toString().trim().isNotEmpty &&
                                  val.toString().trim().length >= 3 &&
                                  val.toString().trim().length <= 12 &&
                                  loginController.emailController.text.isNotEmpty &&
                                  loginController.passwordController.text.isNotEmpty) {
                                loginController.loginValidate.value = true;
                              } else {
                                loginController.loginValidate.value = false;
                              }
                            },
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Name is required";
                              }
                              final trimmedVal = val.trim();
                              if (trimmedVal.length < 3) {
                                return "Name must be at least 3 characters";
                              }
                              if (trimmedVal.length > 12) {
                                return "Name must be at most 12 characters";
                              }
                              return null;
                            },
                            pIcon: Icon(Icons.person, color: AppColor.greyColor1),
                            fieldcontroller: registerController.nameController,
                          ),
                        ),
                        SizedBox(
                          height: context.blockSizeVertical * 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: CustomFormField(
                            hintStyle: TextStyle(fontSize: 13.sp, color: AppColor.greyColor1),
                            isFilled: true,
                            fontsize: 16.sp,
                            fontColor: AppColor.blackColor,
                            bgColor: AppColor.whiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            title: 'Email',
                            onchange: (val) {
                              // Update validation based on name, email, and password
                              if (registerController.nameController.text.trim().isNotEmpty &&
                                  registerController.nameController.text.trim().length >= 3 &&
                                  registerController.nameController.text.trim().length <= 12 &&
                                  val.toString().isNotEmpty &&
                                  loginController.passwordController.text.isNotEmpty) {
                                loginController.loginValidate.value = true;
                              } else {
                                loginController.loginValidate.value = false;
                              }
                            },
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Email is required";
                              }
                              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(val.trim())) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                            pIcon: Icon(Icons.email, color: AppColor.greyColor1),
                            fieldcontroller: loginController.emailController,
                          ),
                        ),
                        SizedBox(
                          height: context.blockSizeVertical * 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: CustomFormField(
                            title: 'Password',
                            fieldcontroller: loginController.passwordController,
                            ispassword: loginController.PasswordVisibility.value,
                            hintStyle: TextStyle(fontSize: 13.sp, color: AppColor.greyColor1),
                            isFilled: true,
                            fontColor: AppColor.blackColor,
                            fontsize: 16.sp,
                            bgColor: AppColor.whiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            sIcon: InkWell(
                              onTap: () {
                                loginController.PasswordVisibility.toggle();
                              },
                              child: Icon(
                                !loginController.PasswordVisibility.value ? Icons.visibility : Icons.visibility_off,
                                color: AppColor.greyColor1,
                              ),
                            ),
                            onchange: (val) {
                              // Update validation based on name, email, and password
                              if (registerController.nameController.text.trim().isNotEmpty &&
                                  registerController.nameController.text.trim().length >= 3 &&
                                  registerController.nameController.text.trim().length <= 12 &&
                                  loginController.emailController.text.isNotEmpty &&
                                  val.toString().isNotEmpty) {
                                loginController.loginValidate.value = true;
                              } else {
                                loginController.loginValidate.value = false;
                              }
                            },
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Password is required";
                              }
                              if (val.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            pIcon: Icon(
                              Icons.lock,
                              color: AppColor.greyColor1,
                            ),
                          ),
                        ),
                        loginController.loginValidate.value
                            ? Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Obx(
                                        () => CustomCheckBox(
                                            isChecked: loginController.rememberMe.value,
                                            onChanged: (val) {
                                              loginController.rememberMe.value = val!;
                                            },
                                            title: 'remember_me'.tr),
                                      ),
                                    ),
                                  ),
                                  CustomRoundButton(
                                    // title: loadingController.isLoading.value ? null : 'sign_up'.tr,
                                    // isLoading: loadingController.isLoading.value,
                                    title: 'sign_up'.tr,
                                    onPress:
                                        //     () async {
                                        //   if (formKey.currentState!.validate()) {
                                        //     loginController.onSignUpLoading.value = true;
                                        //     await Future.delayed(const Duration(seconds: 2));
                                        //     loginController.onSignUpLoading.value = false;
                                        //     loginController.emailController.clear();
                                        //     loginController.passwordController.clear();
                                        //     Get.toNamed(RouteName.dashboardScreen);
                                        //   }
                                        // },
                                        // loadingController.isLoading.value
                                        //     ? null
                                        //     :
                                        () async {
                                      loadingController.setLoading(true);
                                      if (formKey.currentState!.validate()) {
                                        try {
                                          // Use name from nameController instead of defaultName
                                          final response = await SignupService().callSignupService(context, false);
                                          if (response.responseData?.code == 200 ||
                                              response.responseData?.code == 201) {
                                            Utils.toastMessage(context, "${response.responseData?.message}", true);
                                            Future.delayed(const Duration(seconds: 2), () {
                                              Get.toNamed(RouteName.confirmOtpScreen);
                                            });
                                            registerController.emailController.text =
                                                loginController.emailController.text;
                                          } else if (response.responseData?.error != null) {
                                            if (response.responseData?.error == "Validation Error") {
                                              Utils.toastMessage(
                                                  context, "${response.responseData!.getErrorMessage()}", false);
                                            } else {
                                              Utils.toastMessage(
                                                  context, "${response.responseData?.getErrorMessage()}", false);
                                            }
                                          } else {
                                            Utils.toastMessage(context, "Signup failed. Please try again.", false);
                                          }
                                        } catch (error) {
                                          Utils.toastMessage(context, "An error occurred: $error", false);
                                        } finally {
                                          loadingController.setLoading(false);
                                        }
                                      }
                                    },
                                  ),
                                ],
                              )
                            : Center(),
                        SizedBox(
                          height: context.blockSizeVertical * 1,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: CustomText(
                              title: 'or_continue_with'.tr,
                              fontcolor: AppColor.blackColor,
                              fontsize: 15,
                              fontweight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.blockSizeVertical * 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomAuthWidget(
                                  iconPath: ImageAssets.google_logo,
                                  ontap: () {
                                    loginController.googleAuth(context);
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                title: 'Already have an account?',
                                fontcolor: AppColor.blackColor,
                                fontsize: 15,
                                fontweight: FontWeight.w400,
                              ),
                              CustomTextButton(
                                text: 'sign_in'.tr,
                                onPressed: () {
                                  Get.toNamed(RouteName.loginScreen);
                                },
                                fontsize: 16,
                                fontweight: FontWeight.w600,
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
        ),
        Obx(() {
          return loadingController.isLoading.value
              ? Container(
                  color: Colors.black38,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink();
        })
      ],
    );
  }
}
