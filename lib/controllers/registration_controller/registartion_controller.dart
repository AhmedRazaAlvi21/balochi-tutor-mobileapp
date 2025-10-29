import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/AuthModel/SignupModel/SignupResponceModel.dart';
import '../../res/routes/routes_name.dart';
import '../../service/auth_service/resend_otp_verify_services.dart';
import '../../service/auth_service/verify_otp_services.dart';
import '../../utils/utils.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  dynamic selectedEnglishKnowName;
  dynamic selectedStudyingName;
  SignupResponseModel? signupResponse;

  final nameController = TextEditingController();
  RxString defaultName = "".obs;
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxString profilePicturePath = ''.obs;
  RxBool loginValidate = false.obs;
  RxBool rememberMe = true.obs;
  RxBool showPassword = true.obs;
  RxBool confirmShowPassword = true.obs;
  RxBool passwordValidate = false.obs;
  RxBool emailValidate = false.obs;
  RxBool phoneValidate = false.obs;
  RxBool ageValidate = false.obs;
  RxBool nameValidate = false.obs;

  RegExp phoneRegex = RegExp(r'^[+]{1}[0-9]{1,3}[-\.\/ ]?[0-9]{3,14}$');
  RegExp passwordRegex = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*");
  final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9_%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$");
  RegExp numberRegex = RegExp(r'^-?[0-9]+$');

  // ✅ OTP-related state
  RxString otpValue = ''.obs;
  RxInt countdown = 90.obs;
  Timer? countdownTimer;
  RxBool isVerifying = false.obs;
  late bool isForget = false;

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countdownTimer?.cancel();
    super.onClose();
  }

  setSignupResponse(SignupResponseModel response) {
    signupResponse = response;
  }

  bool validatePassword(String value) {
    if (value.length < 6) return false;
    if (!value.contains(RegExp(r'[A-Z]'))) return false;
    if (!value.contains(RegExp(r'[a-z]'))) return false;
    if (!value.contains(RegExp(r'[0-9]'))) return false;
    return true;
  }

  RxInt selectedAppLanguageId = 0.obs;
  RxInt learnAppLanguageId = 0.obs;
  RxInt learnAppLanguageTarget = 0.obs;
  RxInt selectedSocialId = 0.obs;

  // ✅ Initialize the OTP countdown
  void initOtpController(Map<String, dynamic>? arguments, BuildContext context) {
    isForget = arguments?['isForget'] ?? false;
    startCountdown(false, context);
  }

  // ✅ Start or resend OTP
  void startCountdown(bool resendOTP, BuildContext context) async {
    countdown.value = 90;
    countdownTimer?.cancel();

    if (resendOTP) {
      try {
        final response = await ResendVerifyOTPServices().callResendVerifyOTPServices(context);
        if (response.responseData?.code == 200 || response.responseData?.code == 201) {
          Utils.toastMessage(context, response.responseData?.message ?? 'OTP sent successfully', true);
          _startTimer();
        } else {
          Utils.toastMessage(context, response.responseData?.message ?? 'Failed to resend OTP', false);
        }
      } catch (error) {
        Utils.toastMessage(context, "Error during OTP resend: $error", false);
      }
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // ✅ Verify OTP
  Future<void> verifyOtp(BuildContext context, RxBool loading) async {
    if (otpValue.value.length != 4) {
      Utils.toastMessage(context, "Please enter the complete OTP", false);
      return;
    }

    loading.value = true;
    try {
      final response = await VerifyOTPServices().callVerifyOTPServices(context, isForget);

      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        if (isForget) {
          Utils.toastMessage(context, "Create new password", true);
          Future.delayed(const Duration(seconds: 2), () {
            Get.toNamed(RouteName.createNewPasswordScreen);
          });
        } else {
          Utils.toastMessage(context, response.responseData?.message ?? "OTP Verified", true);
          Future.delayed(const Duration(seconds: 2), () {
            Get.toNamed(RouteName.loginScreen);
          });
        }
      } else {
        Utils.toastMessage(context, response.responseData?.message ?? "Invalid OTP. Please try again.", false);
      }
    } catch (error) {
      Utils.toastMessage(context, "An unexpected error occurred: $error", false);
    } finally {
      loading.value = false;
    }
  }
}
