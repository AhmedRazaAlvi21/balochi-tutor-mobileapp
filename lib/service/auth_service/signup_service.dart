import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/AuthModel/SignupModel/SignupResponceModel.dart';
import '../../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class SignupService {
  Future<ApiCallResponse<SignupResponseModel>> callSignupService(BuildContext context, bool signupProfile) async {
    try {
      FormData formData = FormData.fromMap({
        'name': signupProfile 
            ? registerController.nameController.text.trim() 
            : (registerController.nameController.text.trim().isNotEmpty 
                ? registerController.nameController.text.trim() 
                : registerController.defaultName.value),
        'age': signupProfile ? registerController.ageController.text : "",
        'email': signupProfile
            ? registerController.emailController.text.trim()
            : loginController.emailController.text.trim(),
        'password':
            signupProfile ? registerController.passwordController.text : loginController.passwordController.text,
        'device_token': deviceToken,
        if (signupProfile && registerController.profilePicturePath.value.isNotEmpty)
          'user_img': await MultipartFile.fromFile(
            registerController.profilePicturePath.value,
            filename: registerController.profilePicturePath.value.split('/').last,
          ),
      });

      debugPrint("Form data fields: ${formData.fields}");
      debugPrint("Form data files: ${formData.files}");
      if (formData.files.isNotEmpty) {
        for (var file in formData.files) {
          debugPrint("Uploading file: ${file.value.filename}");
        }
      } else {
        debugPrint("No files included in the form data.");
      }
      var response = await Api().postRequest(context, AppUrl.registerApi, formData, sendFormData: true);
      debugPrint(signupProfile ? " Registration ============== $response" : " SignupResponse ============== $response");
      SignupResponseModel responseModel = SignupResponseModel.fromJson(response);
      debugPrint("SignupResponseModel ==================== ${responseModel.toJson()}");
      registerController.setSignupResponse(responseModel);
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
