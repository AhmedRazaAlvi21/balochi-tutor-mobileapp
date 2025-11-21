import 'package:flutter/material.dart';

import '../../models/privacy_policy_model/priavacy_policy_model.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class PrivacyPolicyService {
  Future<ApiCallResponse<PrivacyPolicyResponseModel>> callPrivacyPolicyService(
      BuildContext context, String slug) async {
    try {
      var response = await Api().getRequest(context, "/$slug", sendToken: true);
      debugPrint("PrivacyPolicy  Response: $response");
      PrivacyPolicyResponseModel responseModel = PrivacyPolicyResponseModel.fromJson(response);
      debugPrint("PrivacyPolicy Response Model: ${responseModel.toJson()}");
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
