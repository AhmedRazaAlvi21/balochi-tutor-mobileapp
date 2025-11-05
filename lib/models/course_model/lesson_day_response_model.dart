class LessonDaysResponseModel {
  bool? success;
  String? message;
  int? code;
  List<LessonDaysData>? data;
  LessonDayQuiz? quiz;

  LessonDaysResponseModel({
    this.success,
    this.message,
    this.code,
    this.data,
    this.quiz,
  });

  LessonDaysResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];

    // Handle both possible cases
    if (json['data'] != null && json['data'] is List) {
      data = <LessonDaysData>[];
      json['data'].forEach((v) {
        data!.add(LessonDaysData.fromJson(v));
      });
    }

    if (json['quiz'] != null && json['quiz'] is Map<String, dynamic>) {
      quiz = LessonDayQuiz.fromJson(json['quiz']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['code'] = code;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (quiz != null) {
      map['quiz'] = quiz!.toJson();
    }
    return map;
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
  bool? isCompleted;

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
      this.courseDay,
      this.isCompleted});

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
    isCompleted = json['is_completed'];
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
    data['is_completed'] = isCompleted;
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

class LessonDayQuiz {
  int? id;
  String? title;
  String? description;
  String? status;
  String? quizType;
  int? order;
  int? dayAfter;
  int? duration;
  int? passingScore;
  String? difficulty;
  int? questionsCount;
  String? createdAt;
  String? updatedAt;

  LessonDayQuiz({
    this.id,
    this.title,
    this.description,
    this.status,
    this.quizType,
    this.order,
    this.dayAfter,
    this.duration,
    this.passingScore,
    this.difficulty,
    this.questionsCount,
    this.createdAt,
    this.updatedAt,
  });

  LessonDayQuiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    quizType = json['quiz_type'];
    order = json['order'];
    dayAfter = json['day_after'];
    duration = json['duration'];
    passingScore = json['passing_score'];
    difficulty = json['difficulty'];
    questionsCount = json['questions_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    map['quiz_type'] = quizType;
    map['order'] = order;
    map['day_after'] = dayAfter;
    map['duration'] = duration;
    map['passing_score'] = passingScore;
    map['difficulty'] = difficulty;
    map['questions_count'] = questionsCount;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
