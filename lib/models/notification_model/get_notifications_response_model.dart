class GetNotificationResponseModel {
  bool? success;
  String? message;
  List<GetNotificationData>? data;
  int? code;

  GetNotificationResponseModel({this.success, this.message, this.data, this.code});

  GetNotificationResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetNotificationData>[];
      json['data'].forEach((v) {
        data!.add(GetNotificationData.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class GetNotificationData {
  int? id;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;

  GetNotificationData({this.id, this.title, this.body, this.createdAt, this.updatedAt});

  GetNotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
