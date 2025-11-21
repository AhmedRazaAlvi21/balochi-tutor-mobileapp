class PrivacyPolicyResponseModel {
  bool? success;
  int? code;
  String? data;

  PrivacyPolicyResponseModel({this.success, this.code, this.data});

  PrivacyPolicyResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['data'] = this.data;
    return data;
  }
}
