import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/get_quiz_model/get_quiz_model.dart';
import '../../models/get_quiz_model/submit_quiz/submit_quiz_request_model.dart';
import '../../screens/dashboard/quiz/start_quiz/result_screen.dart';
import '../../service/quiz_service/quiz_question_service.dart';
import '../../service/quiz_service/submit_quiz_service.dart';

class QuizController extends GetxController {
  var isLoading = false.obs;
  var quizData = Rxn<Quiz>();
  var errorMessage = ''.obs;

  var currentQuestionIndex = 0.obs;
  var selectedIndex = RxnInt();
  final List<String> quizTypes = ["sulemani", "makrani"];
  var selectedType = ''.obs;
  Map<String, dynamic> answers = {};

  Future<void> getQuizData(BuildContext context, int quizId, String selectedType) async {
    try {
      if (selectedType.isEmpty) {
        Get.snackbar("Select Type", "Please select a quiz type before starting.",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        return;
      }
      isLoading.value = true;
      errorMessage.value = '';
      final response = await QuizQuestionService().callQuizQuestionService(context, quizId, selectedType);
      if (response.responseData != null && response.responseData?.quiz != null) {
        quizData.value = response.responseData!.quiz!;
      } else {
        errorMessage.value = "Failed to load quiz.";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectOption(int questionId, dynamic answerValue, int optionIndex) {
    answers[questionId.toString()] = answerValue;
    selectedIndex.value = optionIndex;
    update();
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < (quizData.value?.questions?.length ?? 0) - 1) {
      currentQuestionIndex.value++;
      selectedIndex.value = null;
    } else {
      Get.snackbar("Info", "You have reached the last question.");
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    selectedIndex.value = null;
    quizData.value = null;
    answers.clear();
  }

  void setQuizType(String type) {
    selectedType.value = type;
  }

  Future<void> submitQuiz(BuildContext context) async {
    try {
      if (quizData.value == null) {
        Get.snackbar("Error", "No quiz data available.");
        return;
      }
      if (answers.isEmpty) {
        Get.snackbar("Error", "Please answer all questions before submitting.");
        return;
      }
      isLoading.value = true;
      final requestModel = SubmitQuizRequestModel(
        quizId: quizData.value!.id ?? 0,
        type: selectedType.value,
        answers: answers,
      );
      debugPrint("Submit Quiz Request: ${requestModel.toJson()}");
      final response = await SubmitQuizService().callSubmitQuizService(context, requestModel);
      if (response.responseData?.success == true && response.responseData?.code == 200) {
        final result = response.responseData?.data;
        final String? score = result?.score;
        final bool? passed = result?.passed;
        final double scoreValue = double.tryParse(score?.replaceAll('%', '') ?? '0') ?? 0;
        final int totalQuestions = quizData.value?.questions?.length ?? 0;
        final int correctAnswers = ((scoreValue / 100) * totalQuestions).round();
        Get.off(
          () => ResultScreen(
            score: scoreValue.toStringAsFixed(0),
            passed: passed ?? false,
            totalQuestions: totalQuestions,
            correctAnswers: correctAnswers,
          ),
        );
        resetQuiz();
      } else {
        Get.snackbar("Error", "Failed to submit quiz.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
