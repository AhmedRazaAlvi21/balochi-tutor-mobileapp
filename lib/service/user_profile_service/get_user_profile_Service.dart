import 'package:flutter/material.dart';

import '../../models/user_profile_model/user_profile_response_model.dart';
import '../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class UserProfileService {
  Future<ApiCallResponse<UserProfileResponseModel>> callUserProfileService(BuildContext context) async {
    try {
      var response = await Api().getRequest(context, AppUrl.profileApi, sendToken: true);
      debugPrint("User Profile Response: $response");
      UserProfileResponseModel responseModel = UserProfileResponseModel.fromJson(response);
      debugPrint("User Profile Response Model: ${responseModel.toJson()}");
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
