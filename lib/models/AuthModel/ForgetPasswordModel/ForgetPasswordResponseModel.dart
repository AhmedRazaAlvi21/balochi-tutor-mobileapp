class ForgetPasswordResponseModel {
  bool? success;
  int? code;
  String? message;

  ForgetPasswordResponseModel({this.success, this.code, this.message});

  ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
