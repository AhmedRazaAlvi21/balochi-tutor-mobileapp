// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../res/routes/routes_name.dart';
// import '../../../service/auth_service/resend_otp_verify_services.dart';
// import '../../../service/auth_service/verify_otp_services.dart';
// import '../../../utils/utils.dart';
//
// class ConfirmOtpController extends GetxController {
//   RxInt countdown = 90.obs;
//   Timer? countdownTimer;
//   RxString otpValue = ''.obs;
//   RxBool isVerifying = false.obs;
//   late bool isForget;
//
//   void initController(Map<String, dynamic>? arguments, BuildContext context) {
//     isForget = arguments?['isForget'] ?? false;
//     startCountdown(false, context);
//   }
//
//   void startCountdown(bool resendOTP, BuildContext context) async {
//     countdown.value = 90;
//     countdownTimer?.cancel();
//
//     if (resendOTP) {
//       try {
//         final response = await ResendVerifyOTPServices().callResendVerifyOTPServices(context);
//         if (response.responseData?.code == 200 || response.responseData?.code == 201) {
//           Utils.toastMessage(context, response.responseData?.message ?? 'OTP sent successfully', true);
//           _startTimer();
//         } else {
//           Utils.toastMessage(context, response.responseData?.message ?? 'Failed to resend OTP', false);
//         }
//       } catch (error) {
//         Utils.toastMessage(context, "Error during OTP resend: $error", false);
//       }
//     } else {
//       _startTimer();
//     }
//   }
//
//   void _startTimer() {
//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (countdown.value > 0) {
//         countdown.value--;
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//
//   Future<void> verifyOtp(BuildContext context, RxBool loading) async {
//     if (otpValue.value.length != 4) {
//       Utils.toastMessage(context, "Please enter the complete OTP", false);
//       return;
//     }
//
//     loading.value = true;
//     try {
//       final response = await VerifyOTPServices().callVerifyOTPServices(context, isForget);
//
//       if (response.responseData?.code == 200 || response.responseData?.code == 201) {
//         if (isForget) {
//           Utils.toastMessage(context, "Create new password", true);
//           Future.delayed(const Duration(seconds: 2), () {
//             Get.toNamed(RouteName.createNewPasswordScreen);
//           });
//         } else {
//           Utils.toastMessage(context, response.responseData?.message ?? "OTP Verified", true);
//           Future.delayed(const Duration(seconds: 2), () {
//             Get.toNamed(RouteName.loginScreen);
//           });
//         }
//       } else {
//         Utils.toastMessage(context, response.responseData?.message ?? "Invalid OTP. Please try again.", false);
//       }
//     } catch (error) {
//       Utils.toastMessage(context, "An unexpected error occurred: $error", false);
//     } finally {
//       loading.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     countdownTimer?.cancel();
//     super.onClose();
//   }
// }
