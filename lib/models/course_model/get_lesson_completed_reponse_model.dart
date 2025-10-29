class GetLessonCompletedResponseModel {
  bool? success;
  List<GetCompletedLessonsData>? completedLessons;
  int? code;

  GetLessonCompletedResponseModel({this.success, this.completedLessons, this.code});

  GetLessonCompletedResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['completed_lessons'] != null) {
      completedLessons = <GetCompletedLessonsData>[];
      json['completed_lessons'].forEach((v) {
        completedLessons!.add(GetCompletedLessonsData.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (completedLessons != null) {
      data['completed_lessons'] = completedLessons!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class GetCompletedLessonsData {
  int? lessonId;
  String? title;
  String? description;
  int? order;
  String? completedAt;

  GetCompletedLessonsData({this.lessonId, this.title, this.description, this.order, this.completedAt});

  GetCompletedLessonsData.fromJson(Map<String, dynamic> json) {
    lessonId = json['lesson_id'];
    title = json['title'];
    description = json['description'];
    order = json['order'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lesson_id'] = lessonId;
    data['title'] = title;
    data['description'] = description;
    data['order'] = order;
    data['completed_at'] = completedAt;
    return data;
  }
}
