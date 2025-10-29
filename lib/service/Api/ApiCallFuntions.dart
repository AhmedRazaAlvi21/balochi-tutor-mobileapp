import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../res/app_url/app_url.dart';
import '../../res/components/ShowToast/ShowToast.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/KeysConstant.dart';
import '../SheredPreferencesService/SherePrerencesServices.dart';
import 'ApiCallExceptions.dart';

class Api {
  Dio _dio = Dio();

  Future<dynamic> getRequest(context, String apiEndPoint, {bool sendToken = true, bool checkAuthToken = false}) async {
    String apiURLAddress = (AppUrl.baseUrl + apiEndPoint);
    debugPrint("URL: " + apiURLAddress);
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token: $token");
    var responseJson;
    try {
      var response = await _dio.get(
        apiURLAddress,
        options: Options(
          headers: sendToken
              ? {
                  "accept": "application/json",
                  "Authorization": "Bearer $token",
                }
              : {
                  "accept": "application/json",
                },
        ),
      );
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      if (e.response!.data["message"].runtimeType == String) {
      } else {}
      print("Get Api Call Error: $e");
      print("Get Api Call Error: ${e.error}");
      print("Get Api Call Error Response: ${e.response}");
      //ShowToast().showFlushBar(context, message: "${e.response!}", error: true);
      Future.delayed(Duration(seconds: 2), () {
        if (checkAuthToken &&
            ("${e.response!.data['message']}".toLowerCase() == "invalid auth token!" ||
                e.response!.data["statusCode"] == 404)) {
          SharedPreferencesService().remove(KeysConstant.accessToken);
          SharedPreferencesService().remove(KeysConstant.userId);
          Navigator.of(context).pushNamedAndRemoveUntil(RouteName.loginScreen, (route) => false, arguments: {
            "comeFromPinCode": false,
            "showMessage": true,
            "message": "The User login is expired please login again"
          });
        }
        responseJson = _returnListResponse(e.response!);
        return responseJson;
      });
    }
  }

  Future<dynamic> postRequest(context, String apiEndPoint, dynamic body,
      {bool sendToken = false, bool uploadDocument = false, bool sendFormData = false}) async {
    String apiURLAddress = AppUrl.baseUrl + apiEndPoint;

    debugPrint("URL===== $apiURLAddress");
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token==== $token");
    var responseJson;
    try {
      var response = await _dio.post(apiURLAddress,
          options: Options(
              headers: uploadDocument || sendFormData
                  ? {
                      'accept': 'application/json',
                      'Content-Type': 'multipart/form-data',
                      "Authorization": "Bearer $token",
                    }
                  : sendToken
                      ? {
                          "accept": "application/json",
                          "Authorization": "Bearer $token",
                        }
                      : {
                          "accept": "application/json",
                        }),
          data: uploadDocument || sendFormData ? body : jsonEncode(body));
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      print("Post Api Call Error: $e");
      print("Post Api Call Error: ${e.error}");
      print(e.response);
      print(e.response!.data);
      // if (e.response!.data["message"].runtimeType == String) {
      // } else {}
      //ShowToast().showFlushBar(context, message: "${e.response!}", error: true);
      responseJson = _returnListResponse(e.response!);
      return responseJson;
    }
  }

  Future<dynamic> patchRequest(context, String apiEndPoint, dynamic body,
      {bool sendToken = false, bool uploadDocument = false}) async {
    String apiURLAddress = AppUrl.baseUrl + apiEndPoint;

    debugPrint("URL: $apiURLAddress");
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token: $token");
    var responseJson;
    try {
      var response = await _dio.patch(apiURLAddress,
          options: Options(
              headers: uploadDocument
                  ? {
                      'accept': 'application/json',
                      'Content-Type': 'multipart/form-data',
                      'Authorization': 'Bearer $token',
                    }
                  : sendToken
                      ? {
                          'accept': 'application/json',
                          'Content-Type': 'application/json', // ✅ Add this
                          'Authorization': 'Bearer $token',
                        }
                      : {
                          'accept': 'application/json',
                          'Content-Type': 'application/json', // ✅ Optional, but consistent
                        }),
          data: uploadDocument ? body : jsonEncode(body));
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      print("DioException Response: ${e.response}");
      print("DioException Data: ${e.response?.data}");
      print("DioException Status Code: ${e.response?.statusCode}");
      responseJson = _returnListResponse(e.response!);
      ShowToast().showFlushBar(context, message: "${e.response?.data}", error: true);
      return null;
    }
  }

  Future<dynamic> deleteRequest(context, String apiEndPoint, {bool sendToken = true, int? index}) async {
    String apiURLAddress = AppUrl.baseUrl + apiEndPoint;
    debugPrint("URL: " + apiURLAddress);
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token: $token");
    var responseJson;
    try {
      var response = await _dio.delete(apiURLAddress,
          options: Options(
              headers: sendToken
                  ? {
                      "accept": "application/json",
                      "Authorization": "Bearer $token",
                    }
                  : {
                      "accept": "application/json",
                    }));
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      if (e.response!.data["message"].runtimeType == String) {
      } else {}
      print("Delete Api Call Error: $e");
      print("Delete Api Call Error: ${e.error}");
      print(e.response);
      print(e.response!.data);
      //ShowToast().showFlushBar(context, message: "${e.response!}", error: true);
      return null;
    }
  }
}

dynamic _returnListResponse(Response<dynamic> response) {
  debugPrint("StatusCode: ${response.statusCode}");
  switch (response.statusCode) {
    case 200:
      var responseJson = response.data;
      return responseJson;
    case 201:
      var responseJson = response.data;
      return responseJson;
    case 409:
      var responseJson = response.data;
      return responseJson;
    case 404:
      var responseJson = response.data;
      return responseJson;
    case 401:
      var responseJson = response.data;
      return responseJson;
    case 400:
      throw BadRequestException(response.data.toString());
    case 403:
      throw UnAuthorizationException(response.data.toString());
    case 500:
      throw InternalServerException(response.data.toString());
    case 503:
      throw ServerNotFoundException(response.data.toString());
    default:
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
