import 'package:balochi_tutor/models/get_dashboard_model/get_dashboard_response_model.dart';
import 'package:flutter/material.dart';

import '../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class DashboardService {
  Future<ApiCallResponse<GetDashboardDataResponseModel>> callDashboardService(BuildContext context) async {
    try {
      var response = await Api().getRequest(context, AppUrl.dashboardApi, sendToken: true);
      debugPrint("Dashboard Response: $response");
      GetDashboardDataResponseModel responseModel = GetDashboardDataResponseModel.fromJson(response);
      debugPrint("Dashboard Response Model: ${responseModel.toJson()}");
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
