import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Utils.onwillPopFunc(context);
      },
      child: BackgroundWidget(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Obx(
                () => Skeletonizer(
                  enabled: loginController.onLoginLoading.value,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.w),
                        AppAssetsImage(
                          imagePath: ImageAssets.balochiLogo,
                          fit: BoxFit.scaleDown,
                          width: 180.w,
                          height: 180.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomText(
                            title: "Login to Your Account",
                            fontcolor: AppColor.blackColor,
                            fontsize: 26.sp,
                            fontweight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomFormField(
                            title: 'Email',
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
                            fieldcontroller: loginController.emailController,
                            onchange: (val) {
                              if (val.toString().isNotEmpty && loginController.passwordController.text.isNotEmpty) {
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
                            pIcon: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Icon(Icons.email, color: AppColor.greyColor1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.blockSizeVertical * 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomFormField(
                            title: 'Password',
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
                            fieldcontroller: loginController.passwordController,
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
                              if (val.toString().isNotEmpty && loginController.emailController.text.isNotEmpty) {
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
                            pIcon: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Icon(
                                Icons.lock,
                                color: AppColor.greyColor1,
                              ),
                            ),
                          ),
                        ),
                        loginController.loginValidate.value
                            ? Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                                    title: loadingController.isLoading.value ? null : 'sign_in'.tr,
                                    isLoading: loadingController.isLoading.value,
                                    onPress: loadingController.isLoading.value
                                        ? null
                                        : () async {
                                            if (formKey.currentState!.validate()) {
                                              await loginController.userLogin(context);
                                            }
                                          },
                                  ),
                                ],
                              )
                            : Center(),

                        CustomTextButton(
                          text: 'forgot_password'.tr,
                          onPressed: () {
                            Get.toNamed(RouteName.forgotPasswordEmailScreen);
                          },
                          fontsize: 16.sp,
                          fontweight: FontWeight.w600,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: CustomText(
                              title: 'or_continue_with'.tr,
                              fontcolor: AppColor.blackColor,
                              fontsize: 16.sp,
                              fontweight: FontWeight.w600,
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
                                title: 'dont_have_account'.tr,
                                fontcolor: AppColor.greyColor,
                                fontsize: 14.sp,
                                fontweight: FontWeight.w500,
                              ),
                              CustomTextButton(
                                text: 'sign_up'.tr,
                                onPressed: () {
                                  // Get.toNamed(RouteName.RegisterNameScreen);
                                  Get.toNamed(RouteName.signUpScreen);
                                },
                                fontsize: 14.sp,
                                fontweight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: context.orientation == Orientation.portrait
                        //       ? context.blockSizeVertical * 18
                        //       : context.blockSizeHorizontal * 7,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAuthWidget extends StatelessWidget {
  final String iconPath;
  final VoidCallback ontap;

  const CustomAuthWidget({super.key, required this.iconPath, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: context.orientation == Orientation.portrait
            ? context.blockSizeHorizontal * 20
            : context.blockSizeVertical * 20,
        height: context.orientation == Orientation.portrait
            ? context.blockSizeHorizontal * 15
            : context.blockSizeVertical * 15,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SvgPicture.asset(
          iconPath,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
