import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../res/app_url/app_url.dart';
import '../../models/AuthModel/ForgetPasswordModel/ForgetPasswordRequestModel.dart';
import '../../models/AuthModel/ForgetPasswordModel/ForgetPasswordResponseModel.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class ForgetPasswordServices {
  Future<ApiCallResponse<ForgetPasswordResponseModel>> callForgetPasswordServices(BuildContext context) async {
    try {
      ForgetPasswordRequestModel forgetPasswordRequestModel = ForgetPasswordRequestModel(
        email: forgetPasswordController.forgotEmailController.text.trim(),
      );
      debugPrint("VerifyOTPRequestModel: ${forgetPasswordRequestModel.toJson()}");
      var response = await Api().postRequest(context, AppUrl.forgotPasswordApi, forgetPasswordRequestModel.toJson());
      debugPrint("VerifyOTPResponse: $response");
      ForgetPasswordResponseModel responseModel = ForgetPasswordResponseModel.fromJson(response);
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
