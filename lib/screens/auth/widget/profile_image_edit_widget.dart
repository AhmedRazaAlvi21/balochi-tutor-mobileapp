import 'dart:io';

import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controllers/registration_controller/registartion_controller.dart';
import '../../../main.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/custom_text.dart';
import '../register_screens/widget/custom_image_picker_widget.dart';

class ProfileImageEditWidget extends StatelessWidget {
  const ProfileImageEditWidget({
    super.key,
    required this.controller,
  });

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              width: context.blockSizeHorizontal * 20,
              height: context.blockSizeHorizontal * 20,
              child: Obx(
                () => controller.profilePicturePath.value == ''
                    ? CircleAvatar(
                        foregroundImage: AssetImage(ImageAssets.person2),
                        child: Icon(
                          Icons.person,
                        ),
                      )
                    : CircleAvatar(
                        foregroundImage: FileImage(File(controller.profilePicturePath.value)),
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
              title: registerController.emailController.text,
              fontcolor: AppColor.blackColor,
              fontsize: 14.sp,
              fontweight: FontWeight.w500,
            ),
          ],
        )
      ],
    );
  }
}
