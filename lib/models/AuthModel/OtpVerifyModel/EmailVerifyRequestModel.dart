class VerifyOTPRequestModel {
  String? code;
  String? email;
  int? isForget;

  VerifyOTPRequestModel({this.code, this.email, this.isForget});

  VerifyOTPRequestModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    email = json['email'];
    isForget = json['is_forget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['email'] = this.email;
    data['is_forget'] = this.isForget;
    return data;
  }
}
