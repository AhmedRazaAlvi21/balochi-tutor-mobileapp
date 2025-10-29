import 'package:balochi_tutor/res/theme/app_theme.dart';
import 'package:get/get.dart';

import 'controllers/course_controller/course_controller.dart';
import 'controllers/dashboard_controller/dashboard_controller.dart';
import 'controllers/forgot_password_controller/forgot_password_controller.dart';
import 'controllers/loading_controller/loading_controller.dart';
import 'controllers/login_controller/login_controller.dart';
import 'controllers/premium_controller/premium_controller.dart';
import 'controllers/profile_controller/profile_controller.dart';
import 'controllers/registration_controller/registartion_controller.dart';
import 'controllers/settings_controller/settings_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(ProfileController());
    Get.put(RegisterController());
    Get.put(LoginController());
    Get.put(ForgotPasswordController());
    Get.put(LoadingController());
    Get.put(DashboardController());
    Get.put(SettingsController());
    Get.put(PremiumController());
    Get.put(CourseController());
  }
}
