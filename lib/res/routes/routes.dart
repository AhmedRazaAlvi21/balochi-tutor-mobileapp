import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:balochi_tutor/screens/dashboard/setting/setting_screen.dart';
import 'package:get/get.dart';

import '../../screens/auth/create_account/welcome_screen.dart';
import '../../screens/auth/login_screens/confirm_otp_screen.dart';
import '../../screens/auth/login_screens/create_new_password.dart';
import '../../screens/auth/login_screens/forgor_password_email.dart';
import '../../screens/auth/login_screens/login_screen.dart';
import '../../screens/auth/login_screens/sign_in_screen.dart';
import '../../screens/auth/login_screens/sign_up_screen.dart';
import '../../screens/auth/register_screens/register_age_screen.dart';
import '../../screens/auth/register_screens/register_complete_screen.dart';
import '../../screens/auth/register_screens/register_email_screen.dart';
import '../../screens/auth/register_screens/register_name_screen.dart';
import '../../screens/auth/register_screens/register_password_screen.dart';
import '../../screens/auth/splash_screen.dart';
import '../../screens/dashboard/course/lesson_details/lesson_complete_screen.dart';
import '../../screens/dashboard/course/lesson_details/lesson_content_screen.dart';
import '../../screens/dashboard/course/lesson_screen.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/dashboard/setting/about/about_screen.dart';
import '../../screens/dashboard/setting/about/privacy_policy_screen.dart';
import '../../screens/dashboard/setting/about/subscription_info_screen.dart';
import '../../screens/dashboard/setting/about/terms_screen.dart';
import '../../screens/dashboard/setting/notifications.dart';
import '../../screens/dashboard/setting/personal_info/personal_info.dart';
import '../../screens/dashboard/subscription_plan/payment_successful.dart';
import '../../screens/dashboard/subscription_plan/subcription_plan_info.dart';
import '../../screens/dashboard/subscription_plan/subscription_plan.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RouteName.splashScreen, page: () => SplashScreen()),
        GetPage(name: RouteName.welcomeScreen, page: () => WelcomeScreen()),
        GetPage(name: RouteName.registerNameScreen, page: () => RegisterNameScreen()),
        GetPage(name: RouteName.registerAgeScreen, page: () => RegisterAgeScreen()),
        GetPage(name: RouteName.registerEmailScreen, page: () => RegisterEmailScreen()),
        GetPage(name: RouteName.registerPasswordScreen, page: () => RegisterPasswordScreen()),
        GetPage(name: RouteName.registerCompleteScreen, page: () => RegisterCompleteScreen()),
        GetPage(name: RouteName.loginScreen, page: () => LoginScreen()),
        GetPage(name: RouteName.signInScreen, page: () => SignInScreen()),
        GetPage(name: RouteName.signUpScreen, page: () => SignUpScreen()),
        GetPage(name: RouteName.forgotPasswordEmailScreen, page: () => ForgotPasswordEmailScreen()),
        GetPage(name: RouteName.confirmOtpScreen, page: () => ConfirmOtpScreen()),
        GetPage(name: RouteName.createNewPasswordScreen, page: () => CreateNewPasswordScreen()),
        GetPage(name: RouteName.dashboardScreen, page: () => DashboardScreen()),
        GetPage(name: RouteName.lessonScreen, page: () => LessonScreen()),
        GetPage(name: RouteName.lessonContentScreen, page: () => LessonContentScreen()),
        GetPage(name: RouteName.lessonCompleteScreen, page: () => LessonCompleteScreen()),
        GetPage(name: RouteName.settingScreen, page: () => SettingScreen()),
        GetPage(name: RouteName.personalInfo, page: () => PersonalInfo()),
        GetPage(name: RouteName.notifications, page: () => Notifications()),
        GetPage(name: RouteName.aboutScreen, page: () => AboutScreen()),
        GetPage(name: RouteName.privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
        GetPage(name: RouteName.termsScreen, page: () => TermsScreen()),
        GetPage(name: RouteName.subscriptionInfoScreen, page: () => SubscriptionInfoScreen()),
        GetPage(name: RouteName.subscriptionPlan, page: () => SubscriptionPlan()),
        GetPage(name: RouteName.subscriptionPlanInfo, page: () => SubscriptionPlanInfo()),
        GetPage(name: RouteName.paymentSuccessful, page: () => PaymentSuccessful()),
        //GetPage(name: RouteName.resultScreen, page: () => ResultScreen()),
      ];
}
