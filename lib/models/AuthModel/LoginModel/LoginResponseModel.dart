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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['code'] = this.code;
    return data;
  }
}
