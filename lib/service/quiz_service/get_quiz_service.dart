import 'package:balochi_tutor/models/get_quiz_model/get_quiz_model.dart';
import 'package:flutter/material.dart';

import '../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class GetQuizService {
  Future<ApiCallResponse<GetQuizResponseModel>> callGetQuizService(BuildContext context, int id, String type) async {
    try {
      var response = await Api().getRequest(context, "${AppUrl.quizApi}/$id/$type/questions", sendToken: true);
      debugPrint("Quiz Response: $response");
      GetQuizResponseModel responseModel = GetQuizResponseModel.fromJson(response);
      debugPrint("Quiz Response Model: ${responseModel.toJson()}");
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
