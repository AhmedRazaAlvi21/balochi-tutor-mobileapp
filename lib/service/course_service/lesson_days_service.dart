import 'package:balochi_tutor/models/course_model/lesson_day_response_model.dart';
import 'package:flutter/material.dart';

import '../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class LessonDaysService {
  Future<ApiCallResponse<LessonDaysResponseModel>> callLessonDaysService(BuildContext context, int id) async {
    try {
      var response = await Api().getRequest(context, "${AppUrl.lessonDaysApi}/$id/lessons", sendToken: true);
      debugPrint("lessons day Response: $response");
      LessonDaysResponseModel responseModel = LessonDaysResponseModel.fromJson(response);
      debugPrint("lessons day Response Model: ${responseModel.toJson()}");
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
