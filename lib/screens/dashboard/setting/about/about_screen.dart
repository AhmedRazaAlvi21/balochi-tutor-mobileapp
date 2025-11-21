import 'package:balochi_tutor/screens/dashboard/setting/about/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_controller/profile_controller.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/custom_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List aboutSettingOptions = [
      'Privacy Policy',
      'Terms of services',
      'Manage subscription',
    ];
    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            title: 'About',
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.center,
            fontsize: 24.sp,
            fontweight: FontWeight.w700,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) {
              return ListView.builder(
                itemCount: aboutSettingOptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (index == 0) {
                        Get.to(() => PolicyScreen(slug: 'policy', title: 'Privacy Policy'));
                      } else if (index == 1) {
                        Get.to(() => PolicyScreen(slug: 'terms', title: 'Terms of services'));
                      } else {
                        Get.to(() => PolicyScreen(slug: 'manage-subscription', title: 'Manage subscription'));
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    title: CustomText(
                      title: aboutSettingOptions[index],
                      fontcolor: AppColor.blackColor,
                      textalign: TextAlign.left,
                      fontsize: 20,
                      fontweight: FontWeight.w600,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20.0,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
