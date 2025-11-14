import 'package:balochi_tutor/controllers/quiz_controller/quiz_controller.dart';
import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/components/background_widget.dart';
import 'package:balochi_tutor/res/components/bottom_sheet_view.dart';
import 'package:balochi_tutor/res/components/gradientButtonWidget/gradient_button_widget.dart';
import 'package:balochi_tutor/res/components/gradientButtonWidget/gradient_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuizFillTheBlanks extends StatefulWidget {
  final List fillQuestions;

  const QuizFillTheBlanks({super.key, required this.fillQuestions});

  @override
  State<QuizFillTheBlanks> createState() => _QuizFillTheBlanksState();
}

class _QuizFillTheBlanksState extends State<QuizFillTheBlanks> {
  final QuizController controller = Get.find<QuizController>();
  late TextEditingController answerController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    answerController = TextEditingController();
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.fillQuestions[currentIndex];

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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCapsuleQuestion(currentQuestion.question ?? ""),
              SizedBox(height: 50.h),
              _buildCapsuleAnswerField(context, answerController),
              SizedBox(height: 60.h),
              SafeArea(
                child: GradientButtonWidget(
                  title: currentIndex == widget.fillQuestions.length - 1 ? "Submit" : "Next",
                  onTap: () => _handleSubmit(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    final text = answerController.text.trim();
    if (text.isEmpty) {
      Get.snackbar("Incomplete", "Please fill the blank before continuing.",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    final currentQuestion = widget.fillQuestions[currentIndex];
    final correctAnswer = (currentQuestion.answer ?? "").toString().trim();

    // store answer
    controller.answers[currentQuestion.id.toString()] = text;

    bool isCorrect = text.toLowerCase() == correctAnswer.toLowerCase();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BottomSheetView(
        color: isCorrect ? Colors.green : Colors.red,
        headertext: isCorrect ? 'Correct!' : 'Wrong',
        btntext: currentIndex == widget.fillQuestions.length - 1 ? "Finish" : "Next",
        btnOntap: () {
          Get.back();

          if (currentIndex < widget.fillQuestions.length - 1) {
            // Move to next question
            setState(() {
              currentIndex++;
              answerController.clear();
            });
          } else {
            // All done — go to result
            controller.submitQuiz(context);
          }
        },
      ),
    );
  }

  Widget _buildCapsuleQuestion(String question) {
    return GradientTextWidget(
      width: 260.w,
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
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
      width: MediaQuery.of(context).size.width * 0.75,
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
