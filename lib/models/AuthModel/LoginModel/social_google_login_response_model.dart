class SocialGoogleLoginResponseModel {
  bool? success;
  String? message;
  String? token;
  int? statusCode;

  SocialGoogleLoginResponseModel({this.success, this.message, this.token, this.statusCode});

  SocialGoogleLoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    // handle both "statusCode" and "status code"
    statusCode = json['statusCode'] ?? json['status code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    data['statusCode'] = statusCode;
    return data;
  }
}
