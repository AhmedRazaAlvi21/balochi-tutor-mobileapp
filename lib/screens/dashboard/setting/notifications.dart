import 'package:balochi_tutor/controllers/settings_controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/components/ProfileDialogBox/ProfileDialogBox.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: CustomText(
            title: 'Notifications'.tr,
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.center,
            fontsize: 20,
            fontweight: FontWeight.w700,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                children: [
                  Obx(
                    () => ListTile(
                      title: CustomText(
                        title: 'Notifications',
                        fontcolor: AppColor.blackColor,
                        textalign: TextAlign.left,
                        fontsize: 18,
                        fontweight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: MediaQuery.of(context).orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.04
                            : MediaQuery.of(context).size.width * 0.05,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: FlutterSwitch(
                          value: settingsController.allowNotifications.value,
                          toggleSize: 24,
                          activeColor: AppColor.primaryColor,
                          activeToggleColor: AppColor.whiteColor,
                          inactiveColor: AppColor.greyColor.withOpacity(0.5),
                          inactiveToggleColor: AppColor.whiteColor,
                          onToggle: settingsController.toggleNotifications,
                        ),
                      ),
                    ),
                  ),
                  // Obx(
                  //   () => ListTile(
                  //     title: CustomText(
                  //       title: 'App Updates',
                  //       fontcolor: AppColor.blackColor,
                  //       textalign: TextAlign.left,
                  //       fontsize: 18,
                  //       fontweight: FontWeight.w600,
                  //     ),
                  //     trailing: SizedBox(
                  //       height: MediaQuery.of(context).orientation == Orientation.portrait
                  //           ? MediaQuery.of(context).size.height * 0.04
                  //           : MediaQuery.of(context).size.width * 0.05,
                  //       width: MediaQuery.of(context).size.width * 0.15,
                  //       child: FlutterSwitch(
                  //         value: settingsController.allowAppUpdates.value,
                  //         toggleSize: 24,
                  //         activeColor: AppColor.primaryColor,
                  //         activeToggleColor: AppColor.whiteColor,
                  //         inactiveColor: AppColor.greyColor.withOpacity(0.5),
                  //         inactiveToggleColor: AppColor.whiteColor,
                  //         onToggle: settingsController.toggleAppUpdates,
                  //       ),
                  //     ),
                  //   ),
                  //),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: CustomRoundButton(
                  title: 'update_notifications'.tr,
                  isLoading: false,
                  onPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ProfileDialogBox(
                          continueButton: 'Update'.tr,
                          onTap: () async {
                            Get.back();
                            await settingsController.updateNotification(context);
                          },
                          text: "Are you sure you want to update the notifications?",
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
