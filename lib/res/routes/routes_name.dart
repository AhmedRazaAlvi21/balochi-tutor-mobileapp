import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteName {
  static final unknownRoute = GetPage(
    name: '/not-found',
    page: () => Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    ),
  );
  static const String splashScreen = '/';
  static const String welcomeScreen = '/welcomeScreen';
  static const String registerNameScreen = '/registerNameScreen';
  static const String registerAgeScreen = '/registerAgeScreen';
  static const String registerEmailScreen = '/registerEmailScreen';
  static const String registerPasswordScreen = '/registerPasswordScreen';
  static const String registerCompleteScreen = '/registerCompleteScreen';
  static const String loginScreen = '/loginScreen';
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgotPasswordEmailScreen = '/forgotPasswordEmailScreen';
  static const String confirmOtpScreen = '/confirmOtpScreen';
  static const String createNewPasswordScreen = '/createNewPasswordScreen';
  static const String dashboardScreen = '/dashboardScreen';
  static const String lessonScreen = '/lessonScreen';
  static const String lessonContentScreen = '/lessonContentScreen';
  static const String lessonCompleteScreen = '/lessonCompleteScreen';
  static const String settingScreen = '/settingScreen';
  static const String personalInfo = '/personalInfo';
  static const String notifications = '/notifications';
  static const String aboutScreen = '/aboutScreen';
  static const String termsScreen = '/termsScreen';
  static const String subscriptionInfoScreen = '/subscriptionInfoScreen';
  static const String subscriptionPlan = '/subscriptionPlan';
  static const String subscriptionPlanInfo = '/subscriptionPlanInfo';
  static const String paymentSuccessful = '/paymentSuccessful';
  static const String resultScreen = '/resultScreen';
}
