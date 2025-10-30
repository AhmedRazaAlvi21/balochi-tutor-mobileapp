import 'package:balochi_tutor/controllers/profile_controller/profile_controller.dart';
import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/getx_localization/languages.dart';
import 'package:balochi_tutor/res/routes/routes.dart';
import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:balochi_tutor/res/theme/app_theme.dart';
import 'package:balochi_tutor/service/TokenService/Device_token/FetchDeviceToken.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'app_bindings.dart';
import 'controllers/course_controller/course_controller.dart';
import 'controllers/dashboard_controller/dashboard_controller.dart';
import 'controllers/forgot_password_controller/forgot_password_controller.dart';
import 'controllers/loading_controller/loading_controller.dart';
import 'controllers/login_controller/login_controller.dart';
import 'controllers/premium_controller/premium_controller.dart';
import 'controllers/registration_controller/registartion_controller.dart';
import 'controllers/settings_controller/settings_controller.dart';
import 'firebase_options.dart';

String? deviceToken;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  deviceToken = await fetchDeviceToken();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SkeletonizerConfig(
          data: SkeletonizerConfigData(
            effect: const ShimmerEffect(),
            justifyMultiLineText: true,
            textBorderRadius: TextBoneBorderRadius.fromHeightFactor(.5),
            ignoreContainers: false,
          ),
          child: GetMaterialApp(
            title: 'app_name'.tr,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColor.primaryColor,
                surfaceTint: Colors.transparent,
              ),
              primaryColor: AppColor.primaryColor,
              textTheme: GoogleFonts.nunitoTextTheme(
                Theme.of(context).textTheme,
              ),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: AppColor.blackColor,
                ),
              ),
              scaffoldBackgroundColor: Colors.transparent,
            ),
            translations: Languages(),
            locale: const Locale('en', 'US'),
            fallbackLocale: const Locale('en', 'US'),
            initialRoute: RouteName.splashScreen,
            getPages: AppRoutes.appRoutes(),
            unknownRoute: RouteName.unknownRoute,
            initialBinding: AppBindings(),
          ),
        );
      },
    );
  }
}

final RegisterController registerController = Get.put(RegisterController());
final LoginController loginController = Get.put(LoginController());
final ProfileController profileController = Get.put(ProfileController());
final ThemeController themeController = Get.put(ThemeController());
final ForgotPasswordController forgetPasswordController = Get.put(ForgotPasswordController());
final LoadingController loadingController = Get.put(LoadingController());
final DashboardController dashboardController = Get.put(DashboardController());
final SettingsController settingsController = Get.put(SettingsController());
final PremiumController premiumController = Get.put(PremiumController());
final CourseController courseController = Get.put(CourseController());
