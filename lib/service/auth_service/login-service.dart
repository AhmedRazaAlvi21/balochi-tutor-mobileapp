import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../../../utils/KeysConstant.dart';
import '../../main.dart';
import '../../models/AuthModel/LoginModel/LoginRequestModel.dart';
import '../../models/AuthModel/LoginModel/LoginResponseModel.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';
import '../SheredPreferencesService/SherePrerencesServices.dart';

class LoginService {
  Future<ApiCallResponse<LoginResponseModel>> callLoginService(BuildContext context) async {
    try {
      LoginRequestModel loginRequestModel = LoginRequestModel(
        email: loginController.emailController.text.trim(),
        password: loginController.passwordController.text,
        deviceToken: deviceToken,
      );
      debugPrint("VerifyOTPRequestModel: ${loginRequestModel.toJson()}");
      var response = await Api().postRequest(context, AppUrl.loginApi, loginRequestModel.toJson());
      debugPrint("VerifyOTPResponse: $response");
      debugPrint("token: ${response}");
      LoginResponseModel responseModel = LoginResponseModel.fromJson(response);
      debugPrint("VerifyOTPResponseModel: ${responseModel.toJson()}");
      if (responseModel.success == true) {
        String? token = responseModel.token;
        await SharedPreferencesService().setString(KeysConstant.accessToken, token);
        debugPrint("login Access Token: $token");
      } else {
        debugPrint("Login failed: ${responseModel.message}");
      }
      return ApiCallResponse.completed(responseModel);
    } on BadRequestException {
      return ApiCallResponse.error('Bad Request Exception');
    } on UnauthorisedException {
      return ApiCallResponse.error('The User is Un-authorized');
    } on RequestNotFoundException {
      return ApiCallResponse.error('Request Not Found');
    } on UnAuthorizationException {
      return ApiCallResponse.error('The User is Un-authorized');
    } on InternalServerException {
      return ApiCallResponse.error('Internal Server Error');
    } on ServerNotFoundException {
      return ApiCallResponse.error('Server Not Available');
    } on FetchDataException {
      return ApiCallResponse.error('An Error occurred while Fetching the Data');
    } catch (e) {
      return ApiCallResponse.error(e.toString());
    }
  }
}
