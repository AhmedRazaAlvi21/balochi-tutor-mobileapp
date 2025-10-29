import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../main.dart';
import '../../../../res/colors/app_color.dart';

class CustomImagePickerWidget extends StatelessWidget {
  const CustomImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    Future<void> _pickImage(BuildContext context) async {
      try {
        final XFile? pickedFile = await showDialog<XFile?>(
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
                    onTap: () async {
                      final image = await picker.pickImage(source: ImageSource.camera);
                      Navigator.of(context).pop(image);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Pick from Gallery'),
                    onTap: () async {
                      final image = await picker.pickImage(source: ImageSource.gallery);
                      Navigator.of(context).pop(image);
                    },
                  ),
                ],
              ),
            );
          },
        );

        if (pickedFile != null) {
          registerController.profilePicturePath.value = pickedFile.path;
          print("Selected Image Path: ${registerController.profilePicturePath.value}");
        } else {
          print("No image selected");
        }
      } catch (e) {
        debugPrint("Error picking image: $e");
      }
    }

    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        width: context.blockSizeHorizontal * 5,
        height: context.blockSizeHorizontal * 5,
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
