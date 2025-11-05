import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/course_controller/course_controller.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/routes/routes_name.dart';
import '../../widget/course_complete_widget.dart';

class LessonCompleteScreen extends StatelessWidget {
  const LessonCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseCont = Get.find<CourseController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!courseCont.hasFetchedCompletedLessons) {
        courseCont.fetchCompleteLesson(context);
        courseCont.hasFetchedCompletedLessons = true;
      }
    });

    return BackgroundWidget(
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
              icon: const Icon(Icons.arrow_back), onPressed: () => Get.offAllNamed(RouteName.dashboardScreen)),
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
                return CourseCompleteWidget(
                  title: lesson.title ?? "N/A",
                  lessonNo: "Day",
                  lesson: "${lesson.order} / ${lessons.length} Lesson",
                  image: ImageAssets.courseImage,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
