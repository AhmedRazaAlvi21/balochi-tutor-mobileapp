import 'package:balochi_tutor/models/course_model/course_days_resposne_model.dart';
import 'package:flutter/material.dart';

import '../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class CourseDayService {
  Future<ApiCallResponse<CourseDaysResponseModel>> callCourseDayService(BuildContext context, int id) async {
    try {
      var response = await Api().getRequest(context, "${AppUrl.courseApi}/$id/days", sendToken: true);
      debugPrint("Course day Response: $response");
      CourseDaysResponseModel responseModel = CourseDaysResponseModel.fromJson(response);
      debugPrint("Course day Response Model: ${responseModel.toJson()}");
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
