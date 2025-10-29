import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/profile_controller/profile_controller.dart';
import '../../colors/app_color.dart';

class CustomProfileImagePickerWidget extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>(); // GetX Controller

  CustomProfileImagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Image'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Take Photo'),
                    onTap: () {
                      Navigator.of(context).pop();
                      profileController.pickImage(ImageSource.camera); // Pick from camera
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Pick from Gallery'),
                    onTap: () {
                      Navigator.of(context).pop();
                      profileController.pickImage(ImageSource.gallery); // Pick from gallery
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: context.blockSizeHorizontal * 7,
        height: context.blockSizeHorizontal * 7,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(context.blockSizeHorizontal * 1.5),
        ),
        child: Center(
          child: Icon(
            Icons.edit,
            color: AppColor.whiteColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}
