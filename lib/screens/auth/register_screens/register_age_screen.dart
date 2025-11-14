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

class RegisterAgeScreen extends StatelessWidget {
  const RegisterAgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              value: 0.5,
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 70.w,
                                height: 80.h,
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
                                bottom: 5,
                                right: 5,
                                // alignment: Alignment.topCenter,
                                child: CustomImagePickerWidget(),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
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
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'age_screen_text'.tr,
                          fontcolor: AppColor.blackColor,
                          fontsize: 26.sp,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'age'.tr,
                          fontcolor: AppColor.black121,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                      CustomFormField(
                        title: '',
                        keyboardtype: TextInputType.number,
                        onchange: (val) {
                          if (val.toString().isNotEmpty &&
                              val.length >= 2 &&
                              registerController.numberRegex.hasMatch(val.toString())) {
                            registerController.ageValidate.value = true;
                          } else {
                            registerController.ageValidate.value = false;
                          }
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "required";
                          }
                          if (!registerController.numberRegex.hasMatch(val)) {
                            return "Age should be integer";
                          }
                        },
                        // focusnode: controller.nameFocusNode,
                        fieldcontroller: registerController.ageController,
                      ),
                      SizedBox(
                        height: context.blockSizeVertical * 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => registerController.ageValidate.value
                  ? SafeArea(
                      child: CustomRoundButton(
                        title: 'continue'.tr,
                        onPress: () {
                          log('Selected Image Path: ${registerController.profilePicturePath.value}');
                          log('Entered Name: ${registerController.ageController.text}');

                          Get.toNamed(RouteName.registerEmailScreen);
                        },
                      ),
                    )
                  : Center(),
            ),
            SizedBox(
              height: context.blockSizeVertical * 3,
            ),
          ],
        ),
      ),
    );
  }
}
