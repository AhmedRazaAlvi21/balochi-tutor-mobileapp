import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/screens/dashboard/widget/course_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/course_controller/course_controller.dart';
import '../../../controllers/dashboard_controller/dashboard_controller.dart';
import '../../../res/assets/AppNetworkImage.dart';
import '../../../res/components/SearchDropdown/SearchDropdownTextField.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/gradientButtonWidget/gradient_button_widget.dart';
import '../quiz/quiz_screen.dart';
import 'lesson_screen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final CourseController courseController = Get.put(CourseController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (courseController.courseDayData.isEmpty) {
        courseController.getCourseDayData(context);
      }
      // Restore scroll position after data loads
      courseController.restoreCourseScrollPosition();
    });
  }

  @override
  void dispose() {
    // Don't dispose scroll controller here - it's managed by CourseController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        final controller = Get.find<DashboardController>();
        controller.onTabTapped(0);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Course",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.black121,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              final controller = Get.find<DashboardController>();
              controller.onTabTapped(0);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w) + EdgeInsets.only(bottom: 12.h),
                child: SearchDropDownTextField(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  hintText: "Choose day",
                  borderColor: AppColor.whiteColor,
                  fillColor: AppColor.whiteColor,
                  dropDownButton: Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20.sp,
                    color: AppColor.greyColor,
                  ),
                  items: (filter, _) {
                    final list = courseController.courseDayData.toList();
                    final allTitles = <String>[];
                    if (!allTitles.contains("All Days")) {
                      allTitles.insert(0, "All Days");
                    }
                    final filteredTitles = list
                        .where((c) {
                          final dayMatch = "Days ${c.dayNumber}".toLowerCase().contains(filter.toLowerCase());
                          final titleMatch = (c.title?.toLowerCase().contains(filter.toLowerCase()) ?? false);
                          return dayMatch || titleMatch;
                        })
                        .map((c) => "Days ${c.dayNumber}")
                        .toList();

                    allTitles.addAll(filteredTitles);
                    return allTitles;
                  },
                  onChange: (value) {
                    if (value == "All Days" || value.isEmpty) {
                      courseController.filteredCourse.clear();
                      courseController.update(['course_list']);
                    } else {
                      final searchTerm = value.replaceAll("Days ", "").trim();
                      final allCourses = courseController.courseDayData;
                      courseController.filteredCourse.value =
                          allCourses.where((course) => course.dayNumber.toString().contains(searchTerm)).toList();
                      courseController.update(['course_list']);
                    }
                  },
                  validator: (value) => value != null && value.isNotEmpty ? null : "Please select a course",
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (courseController.isLoading.value && courseController.courseDayData.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (courseController.errorMessage.isNotEmpty && courseController.courseDayData.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No courses available at this time.  '),
                          TextButton(
                            onPressed: () async {
                              await courseController.getCourseDayData(context);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  final courseList = courseController.filteredCourse.isNotEmpty
                      ? courseController.filteredCourse
                      : courseController.courseDayData.toList();
                  if (courseList.isEmpty) {
                    return const Center(child: Text('No courses available'));
                  }
                  return GetBuilder<CourseController>(
                    id: "course_list",
                    builder: (_) => RefreshIndicator(
                      color: AppColor.primaryColor,
                      onRefresh: () async {
                        courseController.isCourseDayDataFetched.value = false;
                        await courseController.getCourseDayData(context);
                      },
                      child: ListView.builder(
                        controller: courseController.courseScreenScrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: courseList.length,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        itemBuilder: (context, index) {
                          final course = courseList[index];
                          final day = course.dayNumber ?? index + 1;
                          bool isQuizDay = courseController.isQuizDay(day);
                          int quizNumber = courseController.getQuizNumber(day);
                          int? firstLockedDay = courseController.getFirstLockedDay(courseList);
                          bool isCompleted = courseController.isQuizCompleted(quizNumber, courseList);
                          bool showStartButton = courseController.shouldShowStartQuizButton(
                            quizNumber,
                            firstLockedDay,
                            courseList,
                          );

                          if (isQuizDay) {
                            return Column(
                              children: [
                                showQuizWidget(
                                  quizNumber: quizNumber,
                                  quizId: courseController.quizId,
                                  courseDayId: course.id ?? 0,
                                  message: "Complete Quiz $quizNumber to unlock next 7 days",
                                  showStartButton: showStartButton,
                                  isCompleted: isCompleted,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (course.isLocked == true) return;
                                    courseController.saveCourseScrollPosition();
                                    courseController.selectedCourseId.value = course.id ?? 0;
                                    Get.to(() => LessonScreen(courseId: course.id ?? 0))?.then((_) {
                                      courseController.restoreCourseScrollPosition();
                                    });
                                  },
                                  child: CourseCardWidget(
                                    done: false,
                                    title: "Day $day",
                                    subTitle: course.title ?? 'Balochi',
                                    lesson: course.lessonsCount == null ? "" : "${course.lessonsCount ?? 0} Lessons",
                                    image: appNetworkImage(course.image, 100.w, 100.h, BoxFit.cover),
                                    isLocked: course.isLocked ?? false,
                                  ),
                                ),
                              ],
                            );
                          }
                          return InkWell(
                            onTap: () {
                              if (course.isLocked == true) return;
                              // Save scroll position before navigating
                              courseController.saveCourseScrollPosition();
                              courseController.selectedCourseId.value = course.id ?? 0;

                              debugPrint("selectedCourseId ============ ${courseController.selectedCourseId.value}");

                              Get.to(() => LessonScreen(courseId: course.id ?? 0))?.then((_) {
                                // Restore scroll position when coming back
                                courseController.restoreCourseScrollPosition();
                              });
                            },
                            child: CourseCardWidget(
                              done: false,
                              title: "Day $day",
                              subTitle: course.title ?? 'Balochi',
                              lesson: course.lessonsCount == null ? "" : "${course.lessonsCount ?? 0} Lessons",
                              image: appNetworkImage(course.image, 100.w, 100.h, BoxFit.cover),
                              isLocked: course.isLocked ?? false,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          // // Loading overlay when quiz is being started
          // Obx(() {
          //   if (courseController.isLoading.value && courseController.courseDayData.isNotEmpty) {
          //     return Container(
          //       color: Colors.black.withOpacity(0.5),
          //       child: const Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //     );
          //   }
          //   return const SizedBox.shrink();
          // }),
        ],
      ),
      ),
    );
  }

  Widget showQuizWidget({
    required int quizNumber,
    required int quizId,
    required int courseDayId,
    required String message,
    required bool showStartButton,
    required bool isCompleted,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.w),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isCompleted ? Icons.check_circle : Icons.lock,
                    size: 60,
                    color: isCompleted ? Colors.green : Colors.black,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: 'Quiz: $quizNumber',
                          fontcolor: AppColor.blackColor,
                          fontsize: 18.sp,
                          fontweight: FontWeight.w700,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          title: isCompleted ? "Quiz $quizNumber completed successfully" : message,
                          fontcolor: AppColor.blackColor,
                          fontsize: 14.sp,
                          fontweight: FontWeight.w400,
                        ),
                        SizedBox(height: 20.h),
                        if (showStartButton)
                          Obx(() => GradientButtonWidget(
                                width: 150.w,
                                padding: EdgeInsets.zero,
                                title: courseController.isLoading.value ? "Loading..." : "Start Quiz",
                                onTap: courseController.isLoading.value
                                    ? () {} // Empty function when loading
                                    : () async {
                                        try {
                                          // Set loading to true before starting quiz
                                          courseController.isLoading.value = true;

                                          // First, fetch the quiz ID for this course day
                                          final actualQuizId =
                                              await courseController.getQuizIdForCourseDay(context, courseDayId);
                                          print("quiz id fetched ============ $actualQuizId");

                                          if (actualQuizId > 0) {
                                            await Get.to(() => QuizScreen(quizId: actualQuizId));
                                            courseController.isCourseDayDataFetched.value = false;
                                            await courseController.getCourseDayData(context);
                                          } else {
                                            Get.snackbar("Error", "Quiz not available for this day",
                                                backgroundColor: AppColor.redColor, colorText: Colors.white);
                                          }
                                        } finally {
                                          // Set loading to false after quiz navigation completes
                                          courseController.isLoading.value = false;
                                        }
                                      },
                              ))
                        // else if (isCompleted)
                        //   Container(
                        //     width: 150.w,
                        //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green,
                        //       borderRadius: BorderRadius.circular(8.r),
                        //     ),
                        //     child: CustomText(
                        //       title: "Completed",
                        //       fontcolor: AppColor.whiteColor,
                        //       fontsize: 14.sp,
                        //       fontweight: FontWeight.w600,
                        //       textalign: TextAlign.center,
                        //     ),
                        //   ),
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
}
