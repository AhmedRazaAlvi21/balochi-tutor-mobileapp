import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/screens/dashboard/course/lesson_details/lesson_content_screen.dart';
import 'package:balochi_tutor/screens/dashboard/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_protector/screen_protector.dart';

import '../../../controllers/course_controller/course_controller.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/components/SearchDropdown/SearchDropdownTextField.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/background_widget.dart';
import '../../../res/components/gradientButtonWidget/gradient_button_widget.dart';

class LessonScreen extends StatefulWidget {
  final int? courseId;

  const LessonScreen({super.key, this.courseId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final CourseController courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    _secureScreen();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.courseId != null) {
        courseController.isLessonDayDataFetched.value = false;
        courseController.getLessonDaysData(context, widget.courseId!);
      }
    });
  }

  Future<void> _secureScreen() async {
    try {
      await ScreenProtector.preventScreenshotOn();
      await ScreenProtector.protectDataLeakageOn(); // Optional (for screen recording)
    } catch (e) {
      debugPrint("Screen security error: $e");
    }
  }

  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    ScreenProtector.protectDataLeakageOff();
    courseController.isLessonDayDataFetched.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Lessons",
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
        body: Obx(
          () {
            if (courseController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (courseController.errorMessage.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.w),
                    decoration: BoxDecoration(color: AppColor.whiteColor, borderRadius: BorderRadius.circular(8.r)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.lock, size: 60, color: Colors.black),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    'You Need to Clear Quiz',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    courseController.errorMessage.value ?? "",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  GradientButtonWidget(
                                    width: 150.w,
                                    padding: EdgeInsets.zero,
                                    title: "Quiz",
                                    onTap: () {
                                      Get.to(() => QuizScreen(quizId: courseController.quizId));
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            final lessons = courseController.filteredLesson.isNotEmpty
                ? courseController.filteredLesson
                : courseController.lessonDaysData;

            if (lessons.isEmpty) {
              return const Center(child: Text('No courses available'));
            }

            return Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  SearchDropDownTextField(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    hintText: "Choose Lesson",
                    borderColor: AppColor.whiteColor,
                    fillColor: AppColor.whiteColor,
                    dropDownButton: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 20.sp,
                      color: AppColor.greyColor,
                    ),
                    items: (filter, _) {
                      final list = courseController.lessonDaysData.value ?? [];
                      final allTitles = list
                          .where((c) => c.title?.toLowerCase().contains(filter.toLowerCase()) ?? false)
                          .map((c) => c.title ?? "")
                          .toList();
                      if (!allTitles.contains("All Lessons")) {
                        allTitles.insert(0, "All Lessons");
                      }
                      return allTitles;
                    },
                    onChange: (value) {
                      if (value == "All Lessons" || value.isEmpty) {
                        courseController.filteredLesson.clear();
                      } else {
                        courseController.selectLesson(value);
                        courseController.onSearchLesson(value);
                      }
                    },
                    validator: (value) => value != null && value.isNotEmpty ? null : "Please select a lesson",
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: Obx(() {
                      if (courseController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (courseController.errorMessage.isNotEmpty) {
                        return Center(child: Text(courseController.errorMessage.value));
                      }

                      // ✅ use filteredLesson if available
                      final lessons = courseController.filteredLesson.isNotEmpty
                          ? courseController.filteredLesson
                          : courseController.lessonDaysData;

                      if (lessons.isEmpty) {
                        return const Center(child: Text('No lessons found'));
                      }

                      return ListView.builder(
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          final lesson = lessons[index];
                          final status = courseController.getLessonStatus(lesson, index);
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: status == "resume" ? Border.all(color: Colors.deepPurple, width: 1.5) : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                print("lesson id ========================== ${lesson.id}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonContentScreen(lessonId: lesson.id),
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.only(left: 12, right: 12),
                              leading: AppAssetsImage(
                                imagePath: ImageAssets.pencilPaper,
                                fit: BoxFit.scaleDown,
                                color: status == "resume" ? null : AppColor.black72C,
                                width: 18.w,
                                height: 20.h,
                              ),
                              title: Text(
                                "Lesson ${lesson.order}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                lesson.title ?? "",
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                              ),
                              trailing: _buildStatusButton(status),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusButton(String status) {
    switch (status) {
      case "resume":
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: AppColor.appPrimaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                "Resume From Last",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColor.black121),
          ],
        );

      case "completed":
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColor.black121),
              ),
              child: Row(
                children: const [
                  Icon(Icons.verified, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    "Completed",
                    style: TextStyle(
                      color: AppColor.black121,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColor.black121),
          ],
        );

      default:
        return const Icon(Icons.chevron_right, color: AppColor.black121);
    }
  }
}
