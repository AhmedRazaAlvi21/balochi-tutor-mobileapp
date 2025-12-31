import 'dart:convert';

import 'package:balochi_tutor/controllers/profile_controller/profile_controller.dart';
import 'package:balochi_tutor/res/theme/app_theme.dart';
import 'package:balochi_tutor/service/notification_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/course_controller/course_controller.dart';
import 'controllers/dashboard_controller/dashboard_controller.dart';
import 'controllers/forgot_password_controller/forgot_password_controller.dart';
import 'controllers/loading_controller/loading_controller.dart';
import 'controllers/login_controller/login_controller.dart';
import 'controllers/premium_controller/premium_controller.dart';
import 'controllers/registration_controller/registartion_controller.dart';
import 'controllers/settings_controller/settings_controller.dart';
import 'fcm_service.dart';
import 'firebase_options.dart';
import 'my_app.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final title = message.notification?.title;
  final body = message.notification?.body;
  if (title == null || body == null || title.isEmpty || body.isEmpty) {
    debugPrint("⚠️ Notification ignored (title/body empty)");
    return;
  }

  await NotificationSetting.showNotification(
    id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title: title,
    body: body,
    payload: jsonEncode(message.data),
  );
}

String? deviceToken;
String? userDeviceId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationSetting.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FCMService.initFCM();
  deviceToken = FCMService.deviceToken;
  userDeviceId = await getUserDeviceId();
  debugPrint("USER DEVICE ID (for login restriction): $userDeviceId");
  debugPrint("USER deviceToken ================= ): $deviceToken");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
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

Future<String> getUserDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (GetPlatform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // Stable device ID
  } else if (GetPlatform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? "UNKNOWN_IOS_ID";
  }

  return "UNKNOWN_DEVICE";
}
