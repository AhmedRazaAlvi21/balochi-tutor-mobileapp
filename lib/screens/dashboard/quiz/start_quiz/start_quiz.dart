import 'dart:convert';

import 'package:balochi_tutor/controllers/quiz_controller/quiz_controller.dart';
import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/components/background_widget.dart';
import 'package:balochi_tutor/res/components/bottom_sheet_view.dart';
import 'package:balochi_tutor/res/components/gradientButtonWidget/gradient_button_widget.dart';
import 'package:balochi_tutor/res/components/gradientButtonWidget/gradient_text_widget.dart';
import 'package:balochi_tutor/screens/dashboard/quiz/start_quiz/quiz_fill_the_blanks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StartQuiz extends StatelessWidget {
  final int quizId;
  final String selectedType;

  StartQuiz({super.key, required this.quizId, required this.selectedType});

  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    controller.getQuizData(context, quizId, selectedType);

    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Quiz",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.black121,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Obx(() {
          // Initial loading - when quiz data is being fetched
          if (controller.isLoading.value && controller.quizData.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text("No quiz data found", style: const TextStyle(color: Colors.red)),
            );
          }

          final quiz = controller.quizData.value;
          if (quiz == null || quiz.questions == null || quiz.questions!.isEmpty) {
            return const Center(child: Text("No Quiz Found"));
          }

          final currentQuestion = quiz.questions![controller.currentQuestionIndex.value];
          final List<String> options = List<String>.from(json.decode(currentQuestion.options ?? '[]'));
          final correctIndex = currentQuestion.correctAnswer ?? -1;

          bool isLastQuestion = controller.currentQuestionIndex.value == (quiz.questions!.length - 1);

          // ✅ Change button text dynamically
          String buttonText =
              isLastQuestion ? ((quiz.fillquestions?.isNotEmpty ?? false) ? "Next Section" : "Finish") : "Next";

          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 20.h),
                  GradientTextWidget(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    child: Text(
                      currentQuestion.question ?? "",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black242,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // --- Options List ---
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(options.length, (index) {
                          bool isSelected = controller.selectedIndex.value == index;
                          return GestureDetector(
                            onTap: () {
                              int questionId =
                                  controller.quizData.value?.questions?[controller.currentQuestionIndex.value].id ?? 0;
                              controller.selectOption(
                                questionId,
                                index, // the selected answer value (e.g., option number)
                                index, // to highlight UI
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: GradientTextWidget(
                                  width: 230.w,
                                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                                  gradientColors: isSelected
                                      ? AppColor.gradientButton
                                      : AppColor.gradientButton.map((c) => c.withOpacity(0.4)).toList(),
                                  child: Text(
                                    options[index],
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black242,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  SafeArea(
                    child: GradientButtonWidget(
                      title: buttonText,
                      onTap: () {
                        _onSubmit(context, controller, correctIndex);
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
              // Loading overlay when quiz is being submitted
              if (controller.isLoading.value)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  void _onSubmit(BuildContext context, QuizController controller, int correctIndex) {
    if (controller.selectedIndex.value == null) {
      Get.snackbar("Select an option", "Please choose an answer before continuing.",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    bool isCorrect = controller.selectedIndex.value == correctIndex;

    print("iscorrect ========== $isCorrect");
    final quiz = controller.quizData.value!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BottomSheetView(
        color: isCorrect ? Colors.green : Colors.red,
        headertext: isCorrect ? 'Correct' : 'Wrong',
        btntext: controller.currentQuestionIndex.value == (quiz.questions!.length - 1)
            ? ((quiz.fillquestions?.isNotEmpty ?? false) ? "Next Section" : "Finish")
            : "Next",
        btnOntap: () {
          Get.back();
          if (controller.currentQuestionIndex.value < (quiz.questions!.length - 1)) {
            controller.nextQuestion();
          } else {
            if ((quiz.fillquestions?.isNotEmpty ?? false)) {
              final fillQuestions = List.from(quiz.fillquestions ?? []);
              Get.to(() => QuizFillTheBlanks(fillQuestions: fillQuestions));
            } else {
              controller.submitQuiz(context);
            }
          }
        },
      ),
    );
  }
}
