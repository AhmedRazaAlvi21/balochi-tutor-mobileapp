import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/course_controller/course_controller.dart';
import '../../../../models/course_model/get_lesson_completed_reponse_model.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/routes/routes_name.dart';
import '../../widget/course_complete_widget.dart';

class LessonCompleteScreen extends StatelessWidget {
  const LessonCompleteScreen({super.key});

  String getDayNumberForLesson(GetCompletedLessonsData completedLesson, CourseController controller) {
    final lesson = controller.lessonDaysData.firstWhereOrNull(
      (l) => l.id == completedLesson.lessonId,
    );
    if (lesson != null) {
      if (lesson.courseDay != null && lesson.courseDay!.dayNumber != null) {
        return "Day ${lesson.courseDay!.dayNumber}";
      }
      if (lesson.courseDayId != null) {
        final courseDay = controller.courseDayData.firstWhereOrNull(
          (day) => day.id == lesson.courseDayId,
        );
        if (courseDay != null && courseDay.dayNumber != null) {
          return "Day ${courseDay.dayNumber}";
        }
      }
    }
    if (controller.lessonContent.value != null && controller.lessonContent.value!.id == completedLesson.lessonId) {
      final courseDayId = controller.lessonContent.value!.courseDayId;
      if (courseDayId != null) {
        final courseDay = controller.courseDayData.firstWhereOrNull(
          (day) => day.id == courseDayId,
        );
        if (courseDay != null && courseDay.dayNumber != null) {
          return "Day ${courseDay.dayNumber}";
        }
      }
    }
    return "Day";
  }

  int getTotalLessonsForDay(GetCompletedLessonsData completedLesson, CourseController controller) {
    final lesson = controller.lessonDaysData.firstWhereOrNull(
      (l) => l.id == completedLesson.lessonId,
    );
    int? courseDayId;
    if (lesson != null && lesson.courseDayId != null) {
      courseDayId = lesson.courseDayId;
    } else if (controller.lessonContent.value != null &&
        controller.lessonContent.value!.id == completedLesson.lessonId) {
      courseDayId = controller.lessonContent.value!.courseDayId;
    }
    if (courseDayId != null) {
      final dayLessons = controller.lessonDaysData.where((l) => l.courseDayId == courseDayId).toList();
      if (dayLessons.isNotEmpty) {
        return dayLessons.length;
      }
      final courseDay = controller.courseDayData.firstWhereOrNull(
        (day) => day.id == courseDayId,
      );
      if (courseDay != null && courseDay.lessonsCount != null) {
        return courseDay.lessonsCount!;
      }
    }
    return controller.completedLessonsData.length;
  }

  @override
  Widget build(BuildContext context) {
    final courseCont = Get.find<CourseController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!courseCont.hasFetchedCompletedLessons) {
        courseCont.fetchCompleteLesson(context);
        courseCont.hasFetchedCompletedLessons = true;
      }
      if (!courseCont.isCourseDayDataFetched.value) {
        courseCont.getCourseDayData(context);
      }
    });

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RouteName.dashboardScreen);
        return false;
      },
      child: BackgroundWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Lesson Completed",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.black121,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.offAllNamed(RouteName.dashboardScreen),
            ),
          ),
          body: Obx(() {
            if (courseCont.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            final lessons = courseCont.completedLessonsData;
            if (lessons.isEmpty) {
              return Center(
                child: Text(
                  "No completed lessons found",
                  style: TextStyle(
                    color: AppColor.black121,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await courseCont.fetchCompleteLesson(context);
              },
              child: ListView.builder(
                itemCount: lessons.length,
                padding: EdgeInsets.all(12.w),
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  final dayNumber = getDayNumberForLesson(lesson, courseCont);
                  final totalLessonsForDay = getTotalLessonsForDay(lesson, courseCont);
                  return CourseCompleteWidget(
                    title: lesson.title ?? "N/A",
                    lessonNo: dayNumber,
                    lesson: "${lesson.order} / $totalLessonsForDay Lesson",
                    image: ImageAssets.courseImage,
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
