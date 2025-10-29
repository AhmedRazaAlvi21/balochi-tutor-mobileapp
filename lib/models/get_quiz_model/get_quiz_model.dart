class GetQuizResponseModel {
  bool? success;
  Quiz? quiz;
  int? code;

  GetQuizResponseModel({this.success, this.quiz, this.code});

  GetQuizResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    quiz = json['quiz'] != null ? Quiz.fromJson(json['quiz']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (quiz != null) {
      data['quiz'] = quiz!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class Quiz {
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
  List<Questions>? questions;
  List<Fillquestions>? fillquestions;

  Quiz(
      {this.id,
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
      this.questions,
      this.fillquestions});

  Quiz.fromJson(Map<String, dynamic> json) {
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
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    if (json['fillquestions'] != null) {
      fillquestions = <Fillquestions>[];
      json['fillquestions'].forEach((v) {
        fillquestions!.add(Fillquestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['quiz_type'] = quizType;
    data['order'] = order;
    data['day_after'] = dayAfter;
    data['duration'] = duration;
    data['passing_score'] = passingScore;
    data['difficulty'] = difficulty;
    data['questions_count'] = questionsCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    if (fillquestions != null) {
      data['fillquestions'] = fillquestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  int? quizId;
  String? question;
  String? options;
  int? correctAnswer;
  int? points;
  String? createdAt;
  String? updatedAt;
  int? order;
  String? explanation;
  String? questionType;

  Questions(
      {this.id,
      this.quizId,
      this.question,
      this.options,
      this.correctAnswer,
      this.points,
      this.createdAt,
      this.updatedAt,
      this.order,
      this.explanation,
      this.questionType});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quiz_id'];
    question = json['question'];
    options = json['options'];
    correctAnswer = json['correct_answer'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'];
    explanation = json['explanation'];
    questionType = json['question_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quiz_id'] = quizId;
    data['question'] = question;
    data['options'] = options;
    data['correct_answer'] = correctAnswer;
    data['points'] = points;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order'] = order;
    data['explanation'] = explanation;
    data['question_type'] = questionType;
    return data;
  }
}

class Fillquestions {
  int? id;
  int? quizId;
  String? question;
  String? answer;
  int? points;
  String? explanation;
  String? questionType;
  String? createdAt;
  String? updatedAt;

  Fillquestions(
      {this.id,
      this.quizId,
      this.question,
      this.answer,
      this.points,
      this.explanation,
      this.questionType,
      this.createdAt,
      this.updatedAt});

  Fillquestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quiz_id'];
    question = json['question'];
    answer = json['answer'];
    points = json['points'];
    explanation = json['explanation'];
    questionType = json['question_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quiz_id'] = quizId;
    data['question'] = question;
    data['answer'] = answer;
    data['points'] = points;
    data['explanation'] = explanation;
    data['question_type'] = questionType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
