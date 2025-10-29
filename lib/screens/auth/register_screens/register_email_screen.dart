import 'dart:developer';
import 'dart:io';

import 'package:balochi_tutor/res/extensions.dart';
import 'package:balochi_tutor/screens/auth/register_screens/widget/custom_image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_form_field.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/rounded_linear_progress_bar.dart';
import '../../../res/routes/routes_name.dart';

class RegisterEmailScreen extends StatelessWidget {
  const RegisterEmailScreen({super.key});

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
              value: 0.75,
              backgroundColor: Color(0xffEEEEEE),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: context.blockSizeHorizontal * 20,
                        height: context.blockSizeHorizontal * 20,
                        child: Obx(
                          () => registerController.profilePicturePath.value == ''
                              ? CircleAvatar(
                                  foregroundImage: AssetImage(ImageAssets.person2),
                                  child: Icon(
                                    Icons.person,
                                  ),
                                )
                              : CircleAvatar(
                                  foregroundImage: FileImage(File(registerController.profilePicturePath.value)),
                                  child: Icon(
                                    Icons.person,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        // alignment: Alignment.topCenter,
                        child: CustomImagePickerWidget(),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: registerController.nameController.text,
                        fontcolor: AppColor.blackColor,
                        fontsize: 20.sp,
                        fontweight: FontWeight.w700,
                      ),
                      CustomText(
                        title: 'abc@yourdomain.com',
                        fontcolor: AppColor.blackColor,
                        fontsize: 14.sp,
                        fontweight: FontWeight.w500,
                      ),
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomText(
                    title: 'email_screen_text'.tr,
                    fontcolor: AppColor.blackColor,
                    fontsize: 20.sp,
                    fontweight: FontWeight.w700,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
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
                    if (val.toString().isNotEmpty && registerController.emailRegex.hasMatch(val!)) {
                      registerController.emailValidate.value = true;
                    } else {
                      registerController.emailValidate.value = false;
                    }
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "required";
                    }
                    if (!registerController.emailRegex.hasMatch(val!)) {
                      return "Invalid email address";
                    }
                  },
                  // focusnode: controller.nameFocusNode,
                  fieldcontroller: registerController.emailController,
                ),
              ),
              SizedBox(
                height: context.blockSizeHorizontal * 5,
              ),
              Obx(
                () => registerController.emailValidate.value
                    ? CustomRoundButton(
                        title: 'continue'.tr,
                        onPress: () {
                          log('Selected Image Path: ${registerController.profilePicturePath.value}');
                          log('Entered Name: ${registerController.nameController.text}');
                          log('Entered age: ${registerController.ageController.text}');
                          log('Entered email: ${registerController.emailController.text}');

                          Get.toNamed(RouteName.registerPasswordScreen);
                        },
                      )
                    : Center(),
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
