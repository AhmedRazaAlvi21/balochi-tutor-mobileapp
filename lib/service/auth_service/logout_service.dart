import 'package:balochi_tutor/models/AuthModel/LogoutModel/login_response_model.dart';
import 'package:balochi_tutor/models/AuthModel/LogoutModel/logout_request_model.dart';
import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../../main.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class LogoutService {
  Future<ApiCallResponse<LogoutResponseModel>> callLogoutService(BuildContext context) async {
    try {
      print("user email ============ ${profileController.userProfileData.value?.email}");
      print("user Device  Id ============ $userDeviceId}");
      LogoutRequestModel logoutRequestModel = LogoutRequestModel(
        deviceId: userDeviceId,
      );
      debugPrint("Logout RequestModel: ${logoutRequestModel.toJson()}");
      var response = await Api().postRequest(context, AppUrl.logoutApi, logoutRequestModel.toJson(), sendToken: true);
      debugPrint("Logout Response: $response");
      LogoutResponseModel responseModel = LogoutResponseModel.fromJson(response);
      debugPrint("Logout ResponseModel: ${responseModel.toJson()}");
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
