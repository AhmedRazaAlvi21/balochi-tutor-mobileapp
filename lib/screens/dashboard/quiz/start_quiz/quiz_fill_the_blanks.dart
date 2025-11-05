import 'package:balochi_tutor/controllers/quiz_controller/quiz_controller.dart';
import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/components/background_widget.dart';
import 'package:balochi_tutor/res/components/bottom_sheet_view.dart';
import 'package:balochi_tutor/res/components/gradientButtonWidget/gradient_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/components/gradientButtonWidget/gradient_text_widget.dart';

class QuizFillTheBlanks extends StatelessWidget {
  final List fillQuestions; // list of Fillquestions objects

  const QuizFillTheBlanks({super.key, required this.fillQuestions});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.find<QuizController>();
    final Map<int, TextEditingController> textControllers = {
      for (var q in fillQuestions) (q.id ?? 0): TextEditingController()
    };

    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Fill the Blanks",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.black121,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var q in fillQuestions) ...[
                SizedBox(height: 25.h),
                _buildCapsuleQuestion(q.question ?? ""),
                SizedBox(height: 40.h),
                _buildCapsuleAnswerField(
                  context,
                  textControllers[q.id]!,
                ),
                SizedBox(height: 30.h),
              ],
              SizedBox(height: 50.h),
              GradientButtonWidget(
                title: "Submit Answers",
                onTap: () {
                  final Map<String, dynamic> answers = {};

                  for (var q in fillQuestions) {
                    final id = q.id.toString();
                    final text = textControllers[q.id]?.text.trim() ?? "";

                    if (text.isEmpty) {
                      Get.snackbar("Incomplete", "Please fill all blanks before submitting.",
                          backgroundColor: Colors.redAccent, colorText: Colors.white);
                      return;
                    }

                    answers[id] = text;
                  }

                  controller.answers.addAll(answers);

                  bool allCorrect = true;
                  for (var q in fillQuestions) {
                    String filled = textControllers[q.id]?.text.trim().toLowerCase() ?? "";
                    String correct = (q.answer ?? "").toString().toLowerCase();
                    if (filled != correct) {
                      allCorrect = false;
                      break;
                    }
                  }

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => BottomSheetView(
                      color: allCorrect ? Colors.green : Colors.red,
                      headertext: allCorrect ? 'All Correct!' : 'Some Wrong',
                      btntext: "Finish",
                      btnOntap: () {
                        Get.back();
                        controller.submitQuiz(context);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCapsuleQuestion(String question) {
    return GradientTextWidget(
      width: 230.w,
      child: Text(
        question,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCapsuleAnswerField(BuildContext context, TextEditingController controller) {
    return GradientTextWidget(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: "Type your answer...",
          border: InputBorder.none,
          isDense: true,
        ),
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.black242,
        ),
      ),
    );
  }
}
