import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../../main.dart';
import '../../models/AuthModel/OtpVerifyModel/EmailVerifyRequestModel.dart';
import '../../models/AuthModel/OtpVerifyModel/EmailverifyResponseModel.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class VerifyOTPServices {
  Future<ApiCallResponse<VerifyOTPResponseModel>> callVerifyOTPServices(BuildContext context, bool isForget) async {
    try {
      VerifyOTPRequestModel verifyOTPRequestModel = VerifyOTPRequestModel(
        email: isForget
            ? forgetPasswordController.forgotEmailController.text.trim()
            : registerController.emailController.text.trim(),
        code: registerController.otpValue.value,
        isForget: isForget ? 1 : 0,
      );
      debugPrint("VerifyOTPRequestModel: ${verifyOTPRequestModel.toJson()}");
      var response = await Api().postRequest(context, AppUrl.verifyCodeApi, verifyOTPRequestModel.toJson());
      debugPrint("VerifyOTPResponse: $response");
      VerifyOTPResponseModel responseModel = VerifyOTPResponseModel.fromJson(response);
      debugPrint("VerifyOTPResponseModel: ${responseModel.toJson()}");
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
