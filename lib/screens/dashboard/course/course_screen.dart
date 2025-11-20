import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/screens/dashboard/widget/course_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/course_controller/course_controller.dart';
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
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (courseController.courseDayData.isEmpty) {
        courseController.getCourseDayData(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Column(
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: courseList.length,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      itemBuilder: (context, index) {
                        final course = courseList[index];
                        final day = course.dayNumber ?? index + 1;

                        /// Check if THIS is the first locked day
                        bool isFirstLockedDay = false;

                        if (course.isLocked == true) {
                          if (index == 0) {
                            isFirstLockedDay = true;
                          } else {
                            final previous = courseList[index - 1];
                            if (previous.isLocked == false) {
                              isFirstLockedDay = true;
                            }
                          }
                        }

                        /// SHOW QUIZ ONLY ON FIRST LOCKED DAY
                        /// SHOW QUIZ + DAY CARD BOTH
                        if (isFirstLockedDay) {
                          int quizNumber = getQuizNumber(day);

                          return Column(
                            children: [
                              /// QUIZ WIDGET
                              showQuizWidget(
                                quizNumber: quizNumber,
                                quizId: courseController.quizId,
                                message: "Complete Quiz $quizNumber to unlock next days",
                              ),

                              /// ACTUAL LOCKED DAY CARD (DAY 15 etc)
                              InkWell(
                                onTap: () {},
                                child: CourseCardWidget(
                                  done: false,
                                  title: "Day $day",
                                  subTitle: course.title ?? 'Balochi',
                                  lesson: course.lessonsCount == null ? "" : "${course.lessonsCount ?? 0} Lessons",
                                  image: appNetworkImage(course.image, 60, 60, BoxFit.cover),
                                  isLocked: true,
                                ),
                              ),
                            ],
                          );
                        }
                        return InkWell(
                          onTap: () {
                            if (course.isLocked == true) return;
                            Get.to(() => LessonScreen(courseId: course.id ?? 0));
                          },
                          child: CourseCardWidget(
                            done: false,
                            title: "Day $day",
                            subTitle: course.title ?? 'Balochi',
                            lesson: course.lessonsCount == null ? "" : "${course.lessonsCount ?? 0} Lessons",
                            image: appNetworkImage(course.image, 100, 100, BoxFit.cover),
                            isLocked: course.isLocked ?? false,
                          ),
                        );
                      }),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget showQuizWidget({
    required int quizNumber,
    required int quizId,
    required String message,
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
                  const Icon(Icons.lock, size: 60, color: Colors.black),
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
                          title: message,
                          fontcolor: AppColor.blackColor,
                          fontsize: 14.sp,
                          fontweight: FontWeight.w400,
                        ),
                        SizedBox(height: 20.h),
                        GradientButtonWidget(
                          width: 150.w,
                          padding: EdgeInsets.zero,
                          title: "Start Quiz",
                          onTap: () {
                            Get.to(() => QuizScreen(quizId: quizId));
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

  bool isQuizDay(int day) {
    if (day == 1) return false;
    return (day - 1) % 7 == 0;
  }

  int getQuizNumber(int day) {
    return ((day - 1) / 7).floor();
  }
}
