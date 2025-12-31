import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/get_quiz_model/get_quiz_model.dart';
import '../../models/get_quiz_model/submit_quiz/submit_quiz_request_model.dart';
import '../../screens/dashboard/quiz/start_quiz/result_screen.dart';
import '../../service/quiz_service/quiz_question_service.dart';
import '../../service/quiz_service/submit_quiz_service.dart';
import '../profile_controller/profile_controller.dart';

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

  /// Clear all quiz-related data when logging out or switching users
  void clearQuizData() {
    debugPrint("🧹 Clearing quiz data from QuizController...");

    // Reset quiz state
    resetQuiz();

    // Clear reactive data
    isLoading.value = false;
    errorMessage.value = '';
    selectedType.value = '';

    debugPrint("✅ Quiz data cleared successfully");
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

      debugPrint("🟢 Submit Quiz Request Data:");
      debugPrint("Quiz ID: ${requestModel.quizId}");
      debugPrint("Type: ${requestModel.type}");
      debugPrint("Answers: ${requestModel.answers}");

      final response = await SubmitQuizService().callSubmitQuizService(context, requestModel);
      debugPrint("Submit Quiz Full Response: ${response.responseData}");
      if (response.responseData?.success == true && response.responseData?.code == 200) {
        final result = response.responseData?.data;
        debugPrint("Result Data: $result");
        final String? score = result?.score;
        final bool? passed = result?.passed;
        final double scoreValue = double.tryParse(score?.replaceAll('%', '') ?? '0') ?? 0;
        final int totalQuestions = quizData.value?.questions?.length ?? 0;
        final int correctAnswers = ((scoreValue / 100) * totalQuestions).round();

        debugPrint("✅ Score: $score");
        debugPrint("✅ Passed: $passed");
        debugPrint("✅ Score Value: $scoreValue");
        debugPrint("✅ Total Questions: $totalQuestions");
        debugPrint("✅ Correct Answers: $correctAnswers");

        // Refresh dashboard data before navigating to result screen
        try {
          final profileController = Get.find<ProfileController>();
          await profileController.getDashboardData(context, forceRefresh: true);
        } catch (e) {
          debugPrint("⚠️ Could not refresh dashboard data after quiz: $e");
        }

        // Set loading to false before navigation so ResultScreen can show its own loading if needed
        isLoading.value = false;

        // Navigate to result screen only after all loading is complete
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
        debugPrint("❌ Quiz submission failed.");
        debugPrint("Response Code: ${response.responseData?.code}");
        debugPrint("Response Message: ${response.responseData?.data?.passed}");
        Get.snackbar("Error", "${response.responseData?.type}, Please try again tomorrow.",
            backgroundColor: AppColor.redColor, colorText: AppColor.whiteColor, duration: Duration(seconds: 3));
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("🔥 Exception in submitQuiz: $e");
      Get.snackbar("Error", e.toString());
      isLoading.value = false;
    }
  }
}
