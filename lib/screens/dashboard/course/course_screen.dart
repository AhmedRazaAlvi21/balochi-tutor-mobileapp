import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/screens/dashboard/widget/course_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/course_controller/course_controller.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/components/SearchDropdown/SearchDropdownTextField.dart';
import 'lesson_screen.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.put(CourseController());

    // ✅ Fetch data when the screen first loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      courseController.getCourseDayData(context);
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Courses",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.black121,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (courseController.errorMessage.isNotEmpty) {
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('No courses available at this time.'),
              TextButton(
                  style: ButtonStyle(),
                  onPressed: () async {
                    courseController.isCourseDayDataFetched.value = false;
                    await courseController.getCourseDayData(context);
                  },
                  child: Text('Retry'))
            ],
          ));
        }

        final courseList = courseController.filteredCourse.isNotEmpty
            ? courseController.filteredCourse
            : (courseController.courseDayData ?? []);

        if (courseList.isEmpty) {
          return const Center(child: Text('No courses available'));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SearchDropDownTextField(
                contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                hintText: "Choose course",
                borderColor: AppColor.whiteColor,
                fillColor: AppColor.whiteColor,
                dropDownButton: Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 20.sp,
                  color: AppColor.greyColor,
                ),
                items: (filter, _) {
                  final list = courseController.courseDayData.value ?? [];
                  final allTitles = list
                      .where((c) => c.title?.toLowerCase().contains(filter.toLowerCase()) ?? false)
                      .map((c) => c.title ?? "")
                      .toList();
                  if (!allTitles.contains("All Courses")) {
                    allTitles.insert(0, "All Courses");
                  }
                  return allTitles;
                },
                onChange: (value) {
                  if (value == "All Courses" || value.isEmpty) {
                    // ✅ Show full list again
                    courseController.filteredCourse.clear();
                  } else {
                    // ✅ Apply filter
                    courseController.selectCourse(value);
                    courseController.onSearchCourse(value);
                  }
                },
                validator: (value) => value != null && value.isNotEmpty ? null : "Please select a course",
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: RefreshIndicator(
                  color: AppColor.primaryColor,
                  onRefresh: () async {
                    courseController.isCourseDayDataFetched.value = false;
                    await courseController.getCourseDayData(context);
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: courseList.length,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    itemBuilder: (context, index) {
                      final course = courseList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LessonScreen(courseId: course.id ?? 0)),
                          );
                        },
                        child: CourseCardWidget(
                          done: false,
                          title: course.title ?? 'Unknown Day',
                          subTitle: 'Balochi',
                          lesson: course.description ?? '',
                          image: ImageAssets.courseImage,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
