import 'package:flutter/material.dart';

import '../../../models/AuthModel/ResendOTPVerifyModel/ResendOTPVerifyModel.dart';
import '../../../models/AuthModel/ResendOTPVerifyModel/ResendOTPVerifyResponseModel.dart';
import '../../../res/app_url/app_url.dart';
import '../../main.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class ResendVerifyOTPServices {
  Future<ApiCallResponse<ResendVerifyOTPResponseModel>> callResendVerifyOTPServices(BuildContext context) async {
    try {
      ResendVerifyOTPRequestModel resendVerifyOTPRequestModel = ResendVerifyOTPRequestModel(
        email: registerController.emailController.text.trim(),
      );
      debugPrint("VerifyOTPRequestModel: ${resendVerifyOTPRequestModel.toJson()}");
      var response = await Api().postRequest(context, AppUrl.resendOTPVerifyApi, resendVerifyOTPRequestModel.toJson());
      debugPrint("VerifyOTPResponse: $response");
      ResendVerifyOTPResponseModel responseModel = ResendVerifyOTPResponseModel.fromJson(response);
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
