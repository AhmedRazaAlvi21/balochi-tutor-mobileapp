class LogoutResponseModel {
  bool? success;
  String? message;

  LogoutResponseModel({this.success, this.message});

  LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
