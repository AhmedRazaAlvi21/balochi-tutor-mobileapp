class LessonContentResponseModel {
  bool? success;
  String? message;
  int? code;
  LessonContentData? data;

  LessonContentResponseModel({this.success, this.message, this.code, this.data});

  LessonContentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? LessonContentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LessonContentData {
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

  LessonContentData(
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
      this.updatedAt});

  LessonContentData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
