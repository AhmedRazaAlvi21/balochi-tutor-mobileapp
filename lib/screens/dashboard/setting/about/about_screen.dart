import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_controller/profile_controller.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/custom_text.dart';
import '../../../../res/routes/routes_name.dart';

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
            fontsize: 20,
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
                        Get.toNamed(RouteName.privacyPolicyScreen);
                      } else if (index == 1) {
                        Get.toNamed(RouteName.termsScreen);
                      } else {
                        Get.toNamed(RouteName.subscriptionInfoScreen);
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
