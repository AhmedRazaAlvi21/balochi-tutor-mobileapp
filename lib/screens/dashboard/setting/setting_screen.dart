import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller/profile_controller.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/logout_widget.dart';
import '../../../res/routes/routes_name.dart';
import '../../../service/SheredPreferencesService/SherePrerencesServices.dart';
import '../../../utils/KeysConstant.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            title: 'Settings'.tr,
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.center,
            fontsize: 20,
            fontweight: FontWeight.w700,
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) {
              return ListView.builder(
                itemCount: controller.settingsOptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: controller.settingsOptions[index]['name'] == 'Logout'
                        ? () {
                            print("logout ==============");
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return LogoutWidget(
                                  yesOntap: () async {
                                    Get.back();
                                    // await FirebaseAuth.instance.signOut();
                                    await SharedPreferencesService().remove(KeysConstant.accessToken);
                                    // controller.logoutApi();
                                    Get.offAllNamed(RouteName.loginScreen);
                                  },
                                );
                              },
                            );
                          }
                        : controller.settingsOptions[index]['ontap'],
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    leading: AppAssetsImage(
                      imagePath: controller.settingsOptions[index]['img'],
                      fit: BoxFit.scaleDown,
                      width: 56.w,
                      height: 56.h,
                    ),
                    title: CustomText(
                      title: controller.settingsOptions[index]['name'].toString(),
                      fontcolor: controller.settingsOptions[index]['name'] == 'Logout'
                          ? AppColor.redColor
                          : AppColor.blackColor,
                      textalign: TextAlign.left,
                      fontsize: 20,
                      fontweight: FontWeight.w600,
                    ),
                    trailing: controller.settingsOptions[index]['name'] == 'Logout'
                        ? null
                        : const Icon(
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
