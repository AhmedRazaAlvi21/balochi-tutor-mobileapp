import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/course_controller/course_controller.dart';
import '../../../../res/components/background_widget.dart';
import '../../widget/gradient_dropdown.dart';

class LessonContentScreen extends StatefulWidget {
  final int? lessonId;
  final int? order;

  const LessonContentScreen({super.key, this.lessonId, required this.order});

  @override
  State<LessonContentScreen> createState() => _LessonContentScreenState();
}

class _LessonContentScreenState extends State<LessonContentScreen> {
  final courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      courseController.fetchLessonContent(context, widget.lessonId ?? 0);
      courseController.selectedBalochiType.value = "Sulemani Balochi";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: Text("Lesson ${widget.order}", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Obx(() {
          final lesson = courseController.lessonContent.value;
          if (courseController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (lesson == null) {
            return const Center(child: Text("No lesson content found"));
          }
          String balochiText = "";
          String romanText = "";
          final selected = courseController.selectedBalochiType.value;

          if (selected == "Sulemani Balochi") {
            balochiText = lesson.sulemani ?? "";
            romanText = lesson.romanSulemani ?? "";
          } else if (selected == "Makrani Balochi") {
            balochiText = lesson.makrani ?? "";
            romanText = lesson.romanMakrani ?? "";
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLanguageCard("English", lesson.english ?? "", () {
                  courseController.speak(lesson.english ?? "", langType: "English");
                }),
                const SizedBox(height: 16),
                _buildLanguageCard("Urdu", lesson.urdu ?? "", () {
                  courseController.speak(lesson.urdu ?? "", langType: "Urdu");
                }, isRtl: true),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: GradientDropdown(
                    options: ["Sulemani Balochi", "Makrani Balochi"],
                    initialValue: selected,
                    onChanged: (value) {
                      courseController.selectedBalochiType.value = value;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildLanguageCard(selected, balochiText, () {
                  courseController.speak(balochiText, langType: selected);
                }, isRtl: true),
                const SizedBox(height: 16),
                _buildLanguageCard(
                  selected == "Sulemani Balochi" ? "Roman Sulemani Balochi" : "Roman Makrani Balochi",
                  romanText,
                  () {
                    courseController.speak(romanText, langType: selected);
                    print("Makrani");
                  },
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    await courseController.lessonCompleted(context, widget.lessonId ?? 0, "");
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7558FF),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        "Completed",
                        style: TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLanguageCard(String title, String text, GestureTapCallback onTap, {bool isRtl = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: isRtl ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () async {
                        courseController.setSpeaking(title, true); // start animation
                        await courseController.speak(text, langType: title);
                        courseController.setSpeaking(title, false); // stop after speaking
                      },
                      child: Obx(() {
                        final isSpeaking = courseController.isSpeakingFor(title);

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: isSpeaking
                                  ? [Colors.greenAccent, Colors.green]
                                  : [AppColor.primaryColor, AppColor.primary1],
                            ),
                            boxShadow: [
                              if (isSpeaking)
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.4),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: isSpeaking
                                ? _PulsingIcon(key: ValueKey(true))
                                : Icon(
                                    Icons.volume_up,
                                    key: ValueKey(false),
                                    color: Colors.white,
                                    size: 24,
                                  ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _PulsingIcon extends StatefulWidget {
  const _PulsingIcon({super.key});

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: const Icon(
        Icons.volume_up,
        color: Colors.white,
        size: 26,
      ),
    );
  }
}
