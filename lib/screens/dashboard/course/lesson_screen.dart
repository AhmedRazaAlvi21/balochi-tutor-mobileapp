import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/components/custom_text.dart';
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
    // Don't dispose scroll controller here - it's managed by CourseController
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
              return showQuizWidget();
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
                      final list = courseController.lessonDaysData.toList();
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
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // Force API to refetch fresh data
                        await courseController.getLessonDaysData(context, widget.courseId!, forceRefresh: true);
                      },
                      child: Obx(() {
                        if (courseController.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (courseController.errorMessage.isNotEmpty) {
                          return Center(child: Text(courseController.errorMessage.value));
                        }

                        final lessons = courseController.filteredLesson.isNotEmpty
                            ? courseController.filteredLesson
                            : courseController.lessonDaysData;

                        if (lessons.isEmpty) {
                          return const Center(child: Text('No lessons found'));
                        }

                        return ListView.builder(
                          controller: courseController.lessonScreenScrollController,
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            final lesson = lessons[index];
                            final status = lesson.isCompleted;
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                //border: status == "resume" ? Border.all(color: Colors.deepPurple, width: 1.5) : null,
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
                                  // Save scroll position before navigating
                                  courseController.saveLessonScrollPosition();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LessonContentScreen(lessonId: lesson.id, order: lesson.order),
                                    ),
                                  ).then((_) {
                                    // Restore scroll position when coming back
                                    courseController.restoreLessonScrollPosition();
                                  });
                                },
                                contentPadding: const EdgeInsets.only(left: 12, right: 12),
                                leading: AppAssetsImage(
                                  imagePath: ImageAssets.pencilPaper,
                                  fit: BoxFit.scaleDown,
                                  color: AppColor.black72C,
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
                                trailing: _buildStatusButton(status ?? false),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Center showQuizWidget() {
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
                        CustomText(
                          title: 'You Need to Clear Quiz',
                          fontcolor: AppColor.blackColor,
                          fontsize: 16.sp,
                          fontweight: FontWeight.w700,
                        ),
                        CustomText(
                          title: courseController.errorMessage.value,
                          fontcolor: AppColor.blackColor,
                          fontsize: 14.sp,
                          fontweight: FontWeight.w400,
                        ),
                        SizedBox(height: 20.h),
                        GradientButtonWidget(
                          width: 150.w,
                          padding: EdgeInsets.zero,
                          title: "Quiz",
                          onTap: () async {
                            // First, fetch the quiz ID for this course day
                            if (widget.courseId != null && widget.courseId! > 0) {
                              final actualQuizId =
                                  await courseController.getQuizIdForCourseDay(context, widget.courseId!);
                              debugPrint(
                                  "🔍 Quiz ID fetched in LessonScreen: $actualQuizId for course day: ${widget.courseId}");

                              if (actualQuizId > 0) {
                                await Get.to(() => QuizScreen(quizId: actualQuizId));
                                // Refresh lesson days data after quiz completion
                                courseController.isLessonDayDataFetched.value = false;
                                await courseController.getLessonDaysData(context, widget.courseId!, forceRefresh: true);
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Quiz not available for this day",
                                  backgroundColor: AppColor.redColor,
                                  colorText: Colors.white,
                                );
                              }
                            } else {
                              // Fallback to using the quizId from controller if courseId is not available
                              if (courseController.quizId > 0) {
                                await Get.to(() => QuizScreen(quizId: courseController.quizId));
                                courseController.isLessonDayDataFetched.value = false;
                                await courseController.getLessonDaysData(context, widget.courseId ?? 0,
                                    forceRefresh: true);
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Quiz not available",
                                  backgroundColor: AppColor.redColor,
                                  colorText: Colors.white,
                                );
                              }
                            }
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

  Widget _buildStatusButton(bool status) {
    switch (status) {
      // case "resume":
      //   return Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(8),
      //           gradient: LinearGradient(
      //             colors: AppColor.appPrimaryGradient,
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //           ),
      //         ),
      //         child: const Text(
      //           "Resume From Last",
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontWeight: FontWeight.w700,
      //             fontSize: 10,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(width: 8),
      //       const Icon(Icons.chevron_right, color: AppColor.black121),
      //     ],
      //   );

      case true:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: AppColor.black121),
              ),
              child: Row(
                children: [
                  AppAssetsImage(
                    imagePath: ImageAssets.doneGroup,
                    fit: BoxFit.scaleDown,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "Completed",
                    style: TextStyle(
                      color: AppColor.black121,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            const Icon(Icons.chevron_right, color: AppColor.black121),
          ],
        );

      default:
        return const Icon(Icons.chevron_right, color: AppColor.black121);
    }
  }
}
