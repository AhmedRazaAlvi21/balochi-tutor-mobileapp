import 'package:balochi_tutor/models/course_model/get_lesson_completed_reponse_model.dart';
import 'package:flutter/material.dart';

import '../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class GetLessonCompletedService {
  Future<ApiCallResponse<GetLessonCompletedResponseModel>> callGetLessonCompletedService(BuildContext context) async {
    try {
      var response = await Api().getRequest(context, AppUrl.completedLessons, sendToken: true);
      debugPrint("completed lesson Response: $response");
      GetLessonCompletedResponseModel responseModel = GetLessonCompletedResponseModel.fromJson(response);
      debugPrint("completed lesson Response Model: ${responseModel.toJson()}");
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
