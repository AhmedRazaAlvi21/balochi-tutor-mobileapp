import 'package:balochi_tutor/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../../../utils/KeysConstant.dart';
import '../../models/AuthModel/LoginModel/social_google_login_response_model.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';
import '../SheredPreferencesService/SherePrerencesServices.dart';

class SocialLoginService {
  Future<ApiCallResponse<SocialGoogleLoginResponseModel>> callSocialLoginService(BuildContext context,
      {User? user, String? loginMethod}) async {
    try {
      var loginRequestModel = {
        "user_name": user!.displayName,
        "email": user.email,
        "uuid": user.uid,
        "method": loginMethod ?? "google",
        "user_img": "",
        "device_id": userDeviceId,
      };

      debugPrint("google login Request Model: ${loginRequestModel}");
      var response = await Api().postRequest(context, AppUrl.socialLoginApi, loginRequestModel);
      debugPrint("google login response Response: $response");
      debugPrint("token: ${response}");
      SocialGoogleLoginResponseModel responseModel = SocialGoogleLoginResponseModel.fromJson(response);
      debugPrint("Parsed ResponseModel: success=${responseModel.success}, statusCode=${responseModel.statusCode}");
      debugPrint("google login Request ResponseModel: ${responseModel.toJson()}");
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
