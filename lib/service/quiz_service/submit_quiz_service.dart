import 'package:balochi_tutor/models/get_quiz_model/submit_quiz/submit_quiz_response_model.dart';
import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../../models/get_quiz_model/submit_quiz/submit_quiz_request_model.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class SubmitQuizService {
  Future<ApiCallResponse<SubmitQuizResponseModel>> callSubmitQuizService(
      BuildContext context, SubmitQuizRequestModel submitQuizRequestModel) async {
    try {
      debugPrint("submit Quiz Request Model: ${submitQuizRequestModel.toJson()}");
      var response =
          await Api().postRequest(context, AppUrl.quizSubmit, submitQuizRequestModel.toJson(), sendToken: true);
      debugPrint("submit Quiz Response: $response");
      SubmitQuizResponseModel responseModel = SubmitQuizResponseModel.fromJson(response);
      debugPrint("submit Quiz ResponseModel: ${responseModel.toJson()}");
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
