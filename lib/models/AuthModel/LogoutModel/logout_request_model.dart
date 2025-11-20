class LogoutRequestModel {
  String? deviceId;

  LogoutRequestModel({this.deviceId});

  LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['device_id'] = deviceId;
    return data;
  }
}
