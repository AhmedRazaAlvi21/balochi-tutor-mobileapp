import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/bottom_sheet_view.dart';
import '../../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../../../../res/components/gradientButtonWidget/gradient_text_widget.dart';

class StartQuiz extends StatefulWidget {
  const StartQuiz({super.key});

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  final List<String> options = [
    "تو چون ئے؟",
    "روگ ءَ ئے",
    "من آں",
    "تو کجا",
  ];

  final String correctAnswer = "تو چون ئے؟";

  int? selectedIndex;

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
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: ListView.builder(
                        itemCount: options.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isSelected = selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: GradientTextWidget(
                                width: 160,
                                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                                gradientColors: isSelected
                                    ? AppColor.gradientButton
                                    : AppColor.gradientButton.map((color) => color.withOpacity(0.4)).toList(),
                                child: Text(
                                  options[index],
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black242,
                                  ),
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

            /// Submit Button
            GradientButtonWidget(
              title: "Submit",
              onTap: () {
                _onCheck(context);
              },
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
        "Please choose an answer before submitting.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    bool isMatch = options[selectedIndex!] == correctAnswer;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BottomSheetView(
        color: isMatch ? Colors.green : Colors.red,
        headertext: isMatch ? 'Correct' : 'Wrong',
        btntext: isMatch ? 'Next' : 'Again',
        btnOntap: () {
          Get.back();
          if (isMatch) {
            Get.toNamed(RouteName.quizFillTheBlanks);
          } else {
            Get.back();
          }
          // Move to next or retry
        },
      ),
    );
  }
}
