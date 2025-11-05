import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/screens/dashboard/widget/course_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/course_controller/course_controller.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/components/SearchDropdown/SearchDropdownTextField.dart';
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
      // Only fetch if course list is empty
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
          // 🔍 Search Dropdown
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
                final list = courseController.courseDayData ?? [];
                final allTitles = list
                    .where((c) => "day ${c.dayNumber}".toLowerCase().contains(filter.toLowerCase()))
                    .map((c) => "Day ${c.dayNumber}")
                    .toList();

                if (!allTitles.contains("All Days")) {
                  allTitles.insert(0, "All Days");
                }
                return allTitles;
              },
              onChange: (value) {
                if (value == "All Days" || value.isEmpty) {
                  courseController.filteredCourse.clear();
                } else {
                  courseController.selectCourse(value);
                  courseController.onSearchCourse(value);
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
                      const Text('No courses available at this time.'),
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
                  : (courseController.courseDayData ?? []);

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
                      debugPrint("Course ID: ${course.id}");
                      debugPrint("Course isLocked: ${course.isLocked}");
                      return InkWell(
                        onTap: () async {
                          if (isNavigating) return;
                          isNavigating = true;
                          Get.to(() => LessonScreen(courseId: course.id ?? 0));
                          isNavigating = false;
                        },
                        child: CourseCardWidget(
                          done: false,
                          title: "Day ${course.dayNumber}",
                          subTitle: course.title ?? 'Balochi',
                          image: ImageAssets.courseImage,
                          isLocked: course.isLocked,
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
    );
  }
}
