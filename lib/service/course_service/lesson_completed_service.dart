import 'package:balochi_tutor/models/course_model/lesson_completed_respose_model.dart';
import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class LessonCompletedService {
  Future<ApiCallResponse<LessonCompletedResponseModel>> callLessonCompletedService(
      BuildContext context, int lessonId, var body) async {
    try {
      var response =
          await Api().postRequest(context, "${AppUrl.lessonCompleted}/$lessonId/complete", body, sendToken: true);
      debugPrint("Lesson Completed response : $response");
      LessonCompletedResponseModel responseModel = LessonCompletedResponseModel.fromJson(response);
      debugPrint("Lesson Completed ResponseModel: ${responseModel.toJson()}");
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
