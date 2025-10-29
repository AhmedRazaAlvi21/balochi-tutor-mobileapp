import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../../main.dart';
import '../../models/AuthModel/ResetPasswordModel/ResetPasswordRequestModel.dart';
import '../../models/AuthModel/ResetPasswordModel/ResetPasswordResponseModel.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class ResetPasswordService {
  Future<ApiCallResponse<ResetPasswordResponseModel>> callResetPasswordService(BuildContext context) async {
    try {
      ResetPasswordRequestModel resetPasswordRequestModel = ResetPasswordRequestModel(
        email: forgetPasswordController.forgotEmailController.text.trim(),
        password: forgetPasswordController.newPasswordController.text,
      );
      debugPrint("ResetPasswordRequestModel: ${resetPasswordRequestModel.toJson()}");
      var response = await Api().postRequest(context, AppUrl.resetPasswordApi, resetPasswordRequestModel.toJson());
      debugPrint("ResetPasswordResponse: $response");
      ResetPasswordResponseModel responseModel = ResetPasswordResponseModel.fromJson(response);
      debugPrint("ResetPasswordResponseModel: ${responseModel.toJson()}");
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
