import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../res/app_url/app_url.dart';
import '../../../main.dart';
import '../../models/user_profile_model/user_profile_update_response_model.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class UserProfileUpdateService {
  Future<ApiCallResponse<UserProfileUpdateResponseModel>> callUserProfileUpdateService(BuildContext context) async {
    try {
      debugPrint('image s: ${profileController.userProfileData.value?.userImg}');
      debugPrint('Name s: ${profileController.nameController.text}');
      debugPrint('mobile s: ${profileController.phoneNumberController.text}');
      debugPrint('email s: ${profileController.emailController.text}');
      debugPrint('dob s: ${profileController.DOBController.text}');
      debugPrint('country s: ${profileController.CountryController.text}');
      MultipartFile? userImageFile;
      if (profileController.userImg.value != null) {
        userImageFile = await MultipartFile.fromFile(
          profileController.userImg.value!.path,
          filename: profileController.userImg.value!.path.split('/').last,
        );
      }
      FormData formData;

      if (userImageFile != null) {
        print("userImageFile ======$userImageFile");
        formData = FormData.fromMap({
          "user_img": userImageFile,
          "name": profileController.nameController.text,
          "email": profileController.emailController.text,
          "dob": profileController.DOBController.text,
          "mobile": profileController.phoneNumberController.text,
          "country": profileController.CountryController.text,
        });
      } else {
        print("else userImageFile ======2 ");

        formData = FormData.fromMap({
          "name": profileController.nameController.text,
          "email": profileController.emailController.text,
          "dob": profileController.DOBController.text,
          "mobile": profileController.phoneNumberController.text,
          "country": profileController.CountryController.text,
        });
      }

      var response =
          await Api().postRequest(context, AppUrl.updateProfile, formData, sendToken: true, uploadDocument: true);
      debugPrint("update User Profile Response: $response");
      UserProfileUpdateResponseModel responseModel = UserProfileUpdateResponseModel.fromJson(response);
      debugPrint("update User Profile Response Model: ${responseModel.toJson()}");
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
