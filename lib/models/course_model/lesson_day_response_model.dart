class LessonDaysResponseModel {
  bool? success;
  String? message;
  int? code;
  List<LessonDaysData>? data;

  LessonDaysResponseModel({this.success, this.message, this.code, this.data});

  LessonDaysResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <LessonDaysData>[];
      json['data'].forEach((v) {
        data!.add(LessonDaysData.fromJson(v));
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

class LessonDaysData {
  int? id;
  int? courseDayId;
  String? title;
  String? description;
  int? order;
  String? english;
  String? voiceEnglish;
  String? urdu;
  String? voiceUrdu;
  String? sulemani;
  String? voiceSulemani;
  String? romanSulemani;
  String? voiceRomanSulemani;
  String? makrani;
  String? voiceMakrani;
  String? romanMakrani;
  String? voiceRomanMakrani;
  String? createdAt;
  String? updatedAt;
  CourseDay? courseDay;

  LessonDaysData(
      {this.id,
      this.courseDayId,
      this.title,
      this.description,
      this.order,
      this.english,
      this.voiceEnglish,
      this.urdu,
      this.voiceUrdu,
      this.sulemani,
      this.voiceSulemani,
      this.romanSulemani,
      this.voiceRomanSulemani,
      this.makrani,
      this.voiceMakrani,
      this.romanMakrani,
      this.voiceRomanMakrani,
      this.createdAt,
      this.updatedAt,
      this.courseDay});

  LessonDaysData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseDayId = json['course_day_id'];
    title = json['title'];
    description = json['description'];
    order = json['order'];
    english = json['english'];
    voiceEnglish = json['voice_english'];
    urdu = json['urdu'];
    voiceUrdu = json['voice_urdu'];
    sulemani = json['sulemani'];
    voiceSulemani = json['voice_sulemani'];
    romanSulemani = json['roman_sulemani'];
    voiceRomanSulemani = json['voice_roman_sulemani'];
    makrani = json['makrani'];
    voiceMakrani = json['voice_makrani'];
    romanMakrani = json['roman_makrani'];
    voiceRomanMakrani = json['voice_roman_makrani'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseDay = json['course_day'] != null ? CourseDay.fromJson(json['course_day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_day_id'] = courseDayId;
    data['title'] = title;
    data['description'] = description;
    data['order'] = order;
    data['english'] = english;
    data['voice_english'] = voiceEnglish;
    data['urdu'] = urdu;
    data['voice_urdu'] = voiceUrdu;
    data['sulemani'] = sulemani;
    data['voice_sulemani'] = voiceSulemani;
    data['roman_sulemani'] = romanSulemani;
    data['voice_roman_sulemani'] = voiceRomanSulemani;
    data['makrani'] = makrani;
    data['voice_makrani'] = voiceMakrani;
    data['roman_makrani'] = romanMakrani;
    data['voice_roman_makrani'] = voiceRomanMakrani;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (courseDay != null) {
      data['course_day'] = courseDay!.toJson();
    }
    return data;
  }
}

class CourseDay {
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

  CourseDay(
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

  CourseDay.fromJson(Map<String, dynamic> json) {
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
