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

class RegisterNameScreen extends StatelessWidget {
  const RegisterNameScreen({super.key});

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
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RoundedLinearProgressIndicator(
              value: 0.25,
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
                            clipBehavior: Clip.antiAlias,
                            children: [
                              SizedBox(
                                width: 70.w,
                                height: 70.h,
                                child: Obx(
                                  () => CircleAvatar(
                                    foregroundImage: registerController.profilePicturePath.value.isNotEmpty
                                        ? FileImage(File(registerController.profilePicturePath.value))
                                        : AssetImage(ImageAssets.person2) as ImageProvider,
                                    child:
                                        registerController.profilePicturePath.value.isEmpty ? Icon(Icons.person) : null,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CustomImagePickerWidget(),
                              ),
                            ],
                          ),
                          SizedBox(width: 20.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: 'Andrew Ainsley',
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
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'name_screen_text'.tr,
                          fontcolor: AppColor.blackColor,
                          fontsize: 26.sp,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: 'full_name'.tr,
                          fontcolor: AppColor.black121,
                          fontsize: 16.sp,
                          fontweight: FontWeight.w700,
                        ),
                      ),
                      CustomFormField(
                        title: '',
                        onchange: (val) {
                          registerController.nameValidate.value = val.toString().trim().length >= 3;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Name is required";
                          } else if (val.trim().length < 3) {
                            return "Name must be at least 3 characters long";
                          }
                        },
                        fieldcontroller: registerController.nameController,
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
              () => registerController.nameValidate.value
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomRoundButton(
                        title: 'continue'.tr,
                        onPress: () {
                          log('Selected Image Path: ${registerController.profilePicturePath.value}');
                          log('Entered Name: ${registerController.nameController.text}');
                          Get.toNamed(RouteName.registerAgeScreen);
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
