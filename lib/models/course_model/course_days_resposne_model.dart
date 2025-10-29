class CourseDaysResponseModel {
  bool? success;
  String? message;
  int? code;
  List<CourseDaysData>? data;

  CourseDaysResponseModel({this.success, this.message, this.code, this.data});

  CourseDaysResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <CourseDaysData>[];
      json['data'].forEach((v) {
        data!.add(CourseDaysData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseDaysData {
  int? id;
  int? courseId;
  int? dayNumber;
  String? title;
  String? description;
  String? status;
  int? order;
  String? image;
  String? video;
  String? audio;
  String? createdAt;
  String? updatedAt;

  CourseDaysData(
      {this.id,
      this.courseId,
      this.dayNumber,
      this.title,
      this.description,
      this.status,
      this.order,
      this.image,
      this.video,
      this.audio,
      this.createdAt,
      this.updatedAt});

  CourseDaysData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    dayNumber = json['day_number'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    order = json['order'];
    image = json['image'];
    video = json['video'];
    audio = json['audio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['day_number'] = dayNumber;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['order'] = order;
    data['image'] = image;
    data['video'] = video;
    data['audio'] = audio;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
