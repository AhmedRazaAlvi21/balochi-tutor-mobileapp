import 'package:balochi_tutor/models/payment_process/payment_process_responce_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../res/app_url/app_url.dart';
import '../Api/ApiCallExceptions.dart';
import '../Api/ApiCallFuntions.dart';
import '../Api/ApiCallResponse.dart';

class PaymentProcessService {
  Future<ApiCallResponse<PaymentProcessResponseModel>> callPaymentProcessService({
    required BuildContext context,
    required String planName,
    required String paymentSource,
    required String price,
    required String paymentDate,
    required String screenshotPath,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'plan_name': planName,
        'payment_source': paymentSource,
        'price': price,
        'payment_via_screenshot': await MultipartFile.fromFile(
          screenshotPath,
          filename: screenshotPath.split('/').last,
        ),
        'payment_date': paymentDate,
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
      var response = await Api().postRequest(context, AppUrl.paymentProcess, formData, sendFormData: true);
      PaymentProcessResponseModel responseModel = PaymentProcessResponseModel.fromJson(response);
      debugPrint("SignupResponseModel ==================== ${responseModel.toJson()}");
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
