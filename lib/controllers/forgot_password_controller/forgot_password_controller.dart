import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile_controller/profile_controller.dart';

class ForgotPasswordController extends GetxController {
  final profileController = Get.put(ProfileController());
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  RxBool NewPasswordVisibility = true.obs;
  RxBool ConfirmPasswordVisibility = true.obs;
  RxBool newPasswordValidate = false.obs;
  bool isFromSignup = true;
  RxBool loading = false.obs;
  RxBool verifying = false.obs;
  final forgotEmailController = TextEditingController();
  RxBool fEmailValidate = false.obs;
  final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9_%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$");
  final otpController = TextEditingController();
  RxBool otpValidate = false.obs;
  RxBool rememberMe = true.obs;

  bool validatePassword(String value) {
    if (value.length < 8) {
      return false;
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    if (!value.contains(RegExp(r'[!@#$%^&*+=()/,.?":{}|<>_\-]'))) {
      return false;
    }

    return true;
  }
}
