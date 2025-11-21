class LoginRequestModel {
  String? email;
  String? password;
  String? deviceToken;
  String? deviceId; // ✅ Added

  LoginRequestModel({
    this.email,
    this.password,
    this.deviceToken,
    this.deviceId, // ✅ Added
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceToken = json['device_token'];
    deviceId = json['device_id']; // ✅ Added
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    data['device_token'] = deviceToken;
    data['device_id'] = deviceId; // ✅ Added
    return data;
  }
}
