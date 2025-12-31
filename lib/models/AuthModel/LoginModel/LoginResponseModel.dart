class LoginResponseModel {
  bool? success;
  String? message;
  String? token;
  int? code;

  LoginResponseModel({this.success, this.message, this.token, this.code});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    data['code'] = code;
    return data;
  }
}
