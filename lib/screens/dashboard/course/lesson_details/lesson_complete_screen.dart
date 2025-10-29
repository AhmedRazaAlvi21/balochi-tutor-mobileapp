import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/course_controller/course_controller.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../widget/course_complete_widget.dart';

class LessonCompleteScreen extends StatefulWidget {
  const LessonCompleteScreen({super.key});

  @override
  State<LessonCompleteScreen> createState() => _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<LessonCompleteScreen> {
  final courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    courseController.fetchCompleteLesson(context);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Lesson Completed",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: AppColor.black121),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Obx(
          () {
            final lessons = courseController.completedLessonsData;
            if (courseController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: lessons.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(12.w),
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                return CourseCompleteWidget(
                  title: lesson.title ?? "N/A",
                  lessonNo: "Lesson ID: ${lesson.lessonId}",
                  lesson: "Order: ${lesson.order}",
                  image: ImageAssets.courseImage,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
