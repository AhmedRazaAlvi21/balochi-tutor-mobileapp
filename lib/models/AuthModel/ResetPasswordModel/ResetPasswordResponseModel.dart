class ResetPasswordResponseModel {
  bool? success;
  String? message;
  int? code;

  ResetPasswordResponseModel({this.success, this.message, this.code});

  ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}
