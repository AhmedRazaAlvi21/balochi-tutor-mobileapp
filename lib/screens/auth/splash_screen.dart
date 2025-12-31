import 'dart:async';

import 'package:balochi_tutor/res/components/custom_text.dart';
import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller/dashboard_controller.dart';
import '../../res/assets/image_assets.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/app_assets_image.dart';
import '../../res/components/background_widget.dart';
import '../../res/routes/routes_name.dart';
import '../../service/SheredPreferencesService/SherePrerencesServices.dart';
import '../../utils/KeysConstant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
      print("login token =============== $token");
      if (token != null && token.isNotEmpty) {
        // Reset dashboard to Home tab before navigating
        try {
          final dashboardController = Get.find<DashboardController>();
          dashboardController.resetToHome();
        } catch (e) {
          // Controller might not exist yet, it will be created with index 0
        }
        Get.offAllNamed(RouteName.dashboardScreen);
      } else {
        Get.toNamed(RouteName.welcomeScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            height: context.orientation == Orientation.portrait
                ? context.blockSizeVertical * 100
                : context.blockSizeHorizontal * 100,
            width: context.orientation == Orientation.landscape
                ? context.blockSizeVertical * 100
                : context.blockSizeHorizontal * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppAssetsImage(
                        imagePath: ImageAssets.balochiLogo,
                        fit: BoxFit.scaleDown,
                        width: 190.w,
                        height: 190.h,
                      ),
                      CustomText(title: "Balochi", fontsize: 48.sp, fontweight: FontWeight.w700),
                      CustomText(title: "Tutor", fontsize: 24.sp, fontweight: FontWeight.w700),
                    ],
                  ),
                ),
                SpinKitCircle(
                  size: 55.0,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: context.blockSizeVertical * 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
