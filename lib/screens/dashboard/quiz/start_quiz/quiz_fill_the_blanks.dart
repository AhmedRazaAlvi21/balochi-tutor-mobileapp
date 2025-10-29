import 'package:balochi_tutor/screens/dashboard/quiz/start_quiz/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/bottom_sheet_view.dart';
import '../../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../../../../res/components/gradientButtonWidget/gradient_text_widget.dart';

class QuizFillTheBlanks extends StatefulWidget {
  const QuizFillTheBlanks({super.key});

  @override
  State<QuizFillTheBlanks> createState() => _QuizFillTheBlanksState();
}

class _QuizFillTheBlanksState extends State<QuizFillTheBlanks> {
  final List<String> options = [
    "تو ___ ئے؟",
    "روگ ___",
    "من ___",
    "تو ___",
  ];

  final int correctIndex = 0;
  final String correctWord = "روگ";

  final List<TextEditingController> controllers = [];
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    controllers.addAll(List.generate(options.length, (_) => TextEditingController()));
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Quiz",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: AppColor.black121),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),

            /// Question
            GradientTextWidget(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Text(
                "How are you?",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColor.black242),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 15),
                // child: GradientDropdown(
                //   options: ["Sulemani", "Makrani"],
                //   initialValue: "Sulemani",
                // ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.75,
                      child: ListView.builder(
                        itemCount: options.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isSelected = selectedIndex == index;
                          List<String> parts = options[index].split("___");

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: GradientTextWidget(
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                                gradientColors: isSelected
                                    ? AppColor.gradientButton
                                    : AppColor.gradientButton.map((c) => c.withOpacity(0.4)).toList(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      parts.first,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black242,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: isSelected
                                          ? TextField(
                                              controller: controllers[index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black242,
                                              ),
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.symmetric(vertical: 2),
                                                border: UnderlineInputBorder(),
                                              ),
                                            )
                                          : Text(
                                              "___",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black242.withOpacity(0.5),
                                              ),
                                            ),
                                    ),
                                    Text(
                                      parts.length > 1 ? parts.last : '',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black242,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GradientButtonWidget(
              title: "Submit",
              onTap: () => _onCheck(context),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  void _onCheck(BuildContext context) {
    if (selectedIndex == null) {
      Get.snackbar(
        "Select an option",
        "Please choose one and fill in the blank.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    String filledWord = controllers[selectedIndex!].text.trim();

    if (filledWord.isEmpty) {
      Get.snackbar(
        "Blank is empty",
        "Please enter a word to fill the blank.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    bool isCorrect = selectedIndex == correctIndex && filledWord == correctWord;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BottomSheetView(
        color: isCorrect ? Colors.green : Colors.red,
        headertext: isCorrect ? 'Correct' : 'Wrong',
        btntext: isCorrect ? 'Next' : 'Again',
        btnOntap: () {
          Get.back();

          if (isCorrect) {
            // Get.toNamed(RouteName.resultScreen);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResultScreen(
                  totalQuestions: 10,
                  correctAnswers: 9,
                  done: true,
                ),
              ),
            );
          } else {
            //Get.toNamed(RouteName.resultScreen);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResultScreen(
                  totalQuestions: 10,
                  correctAnswers: 4,
                  done: false,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
