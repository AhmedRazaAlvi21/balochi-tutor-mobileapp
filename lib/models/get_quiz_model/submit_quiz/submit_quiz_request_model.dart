class SubmitQuizRequestModel {
  final int quizId;
  final String type;
  final Map<String, dynamic> answers;

  SubmitQuizRequestModel({
    required this.quizId,
    required this.type,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      "quiz_id": quizId,
      "type": type,
      "answers": answers,
    };
  }
}
