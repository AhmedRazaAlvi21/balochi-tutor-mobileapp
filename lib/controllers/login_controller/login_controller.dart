import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth_repository/social_auth_repository.dart';
import '../../main.dart';
import '../../res/routes/routes_name.dart';
import '../../service/auth_service/login-service.dart';
import '../../service/auth_service/social_login_service.dart';
import '../../utils/utils.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool PasswordVisibility = true.obs;
  RxBool loginValidate = false.obs;

  RxBool rememberMe = true.obs;
  RxBool rememberMe2 = true.obs;
  final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9_%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$");
  RxBool onLoginLoading = false.obs;
  RxBool onSignInLoading = false.obs;
  RxBool onSignUpLoading = false.obs;
  final _socialApi = socialAuthRepository();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void googleAuth(BuildContext context) {
    loadingController.setLoading(true);
    _socialApi.googleAuth().then((response) {
      if (response != null) {
        SocialLoginService().callSocialLoginService(context, user: response).then((value) {
          print("status code ======================= ${value.responseData?.statusCode}");

          loadingController.setLoading(false);
          if (value.responseData?.statusCode == 200 || value.responseData?.statusCode == 201) {
            Utils.toastMessage(context, "Login Successfully", true);

            Future.delayed(const Duration(seconds: 2), () {
              Get.offAllNamed(RouteName.dashboardScreen);
            });
          } else if (value.responseData?.success == false) {
            Utils.toastMessage(context, "${value.responseData?.message}", false);
          } else {
            Utils.toastMessage(context, "Signup failed. Please try again.", false);
          }
        });
      } else {
        loadingController.setLoading(false);
      }
    });
  }

  Future<void> userLogin(BuildContext context) async {
    loadingController.setLoading(true);
    try {
      final response = await LoginService().callLoginService(context);

      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        Utils.toastMessage(context, "${response.responseData?.message}", true);

        // ✅ If OTP required, go to OTP screen
        if (response.responseData?.success == true &&
            (response.responseData?.message == "OTP sent again." || response.responseData?.message == "OTP sent.")) {
          Future.delayed(const Duration(seconds: 2), () {
            Get.toNamed(RouteName.confirmOtpScreen, arguments: {'isForget': false});
          });
        } else {
          profileController.getUserProfileData(context);
          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed(RouteName.dashboardScreen);
          });
        }
      } else {
        Utils.toastMessage(context, "${response.responseData?.message}", false);
      }
    } catch (error) {
      Utils.toastMessage(context, "An error occurred: $error", false);
    } finally {
      loadingController.setLoading(false);
    }
  }
}
