import 'package:balochi_tutor/models/course_model/course_days_resposne_model.dart';
import 'package:balochi_tutor/models/course_model/get_lesson_completed_reponse_model.dart';
import 'package:balochi_tutor/models/course_model/lesson_day_response_model.dart';
import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/components/custom_text.dart';
import 'package:balochi_tutor/service/course_service/course_day_service.dart';
import 'package:balochi_tutor/service/course_service/get_lesson_completed_service.dart';
import 'package:balochi_tutor/service/course_service/lesson_completed_service.dart';
import 'package:balochi_tutor/service/course_service/lesson_days_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/course_model/lesson_content_response_model.dart';
import '../../res/components/custom_rounded_button.dart';
import '../../res/routes/routes_name.dart';
import '../../service/course_service/lesson_content_service.dart';
import '../../utils/utils.dart';

class CourseController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();

  final TextEditingController courseSearchController = TextEditingController();
  final TextEditingController lessonSearchController = TextEditingController();
  var lessonDaysData = <LessonDaysData>[].obs;
  var completedLessonsData = <GetCompletedLessonsData>[].obs;
  var filteredLesson = <LessonDaysData>[].obs;
  var courseDayData = <CourseDaysData>[].obs;
  var filteredCourse = <CourseDaysData>[].obs;
  var lessonContent = Rxn<LessonContentData>();

  var isCourseDayDataFetched = false.obs;
  var isLessonDayDataFetched = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedCourse = "".obs;
  var selectedLesson = "".obs;
  var selectedBalochiType = "Sulemani dialect".obs;
  var isSpeaking = false.obs;
  var quizId = 0;
  bool hasFetchedCompletedLessons = false;
  var isDropdownExpanded = false.obs;
  var completedQuizNumber = 0.obs;

  @override
  void onInit() {
    super.onInit();
    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setStartHandler(() {
      isSpeaking.value = true;
      print("🔊 Speaking started");
    });
    flutterTts.setCompletionHandler(() {
      isSpeaking.value = false;
      print("✅ Speaking completed");
    });
    flutterTts.setCancelHandler(() {
      isSpeaking.value = false;
      print("⛔ Speech cancelled");
    });
    flutterTts.setErrorHandler((msg) {
      isSpeaking.value = false;
      print("❌ TTS Error: $msg");
    });
  }

  Future<void> getLessonDaysData(BuildContext context, int courseId, {bool forceRefresh = false}) async {
    if (isLessonDayDataFetched.value && !forceRefresh) return;
    try {
      isLoading.value = true;
      errorMessage.value = '';
      debugPrint("✅ Lesson Days data fetched for course ID: $courseId");
      final response = await LessonDaysService().callLessonDaysService(context, courseId);
      final responseData = response.responseData;

      if (responseData?.code == 200 || responseData?.code == 201) {
        lessonDaysData.value = responseData?.data ?? [];
        isLessonDayDataFetched.value = true;
        quizId = 0;
      } else if (responseData?.quiz != null) {
        quizId = responseData?.quiz?.id ?? 0;
        errorMessage.value = responseData?.message ?? "You must complete and pass the quiz to access this day";
        debugPrint("Quiz required with ID: $quizId");
      } else {
        errorMessage.value = responseData?.message ?? 'Something went wrong';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCompleteLesson(BuildContext context) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await GetLessonCompletedService().callGetLessonCompletedService(context);
      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        completedLessonsData.value = response.responseData?.completedLessons ?? [];
      } else {
        debugPrint("Failed to fetch course data: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint("❌ Exception in getCourseDayData: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectCourse(String? course) {
    selectedCourse.value = course!;
    update();
  }

  void selectLesson(String? lesson) {
    selectedLesson.value = lesson!;
    update();
  }

  Future<void> speak(String text, {String? langType}) async {
    if (text.trim().isEmpty) return;
    try {
      await flutterTts.stop();
      await Future.delayed(const Duration(milliseconds: 200));
      String langCode = "en-US";
      if (langType != null) {
        final l = langType.toLowerCase();
        if (l.contains("urdu")) {
          langCode = "ur-PK";
        } else if (l.contains("sulemani") || l.contains("makrani")) {
          langCode = "ur-PK";
        } else if (l.contains("english")) {
          langCode = "en-US";
        }
      }
      await flutterTts.setLanguage(langCode);
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.45);
      await Future.delayed(const Duration(milliseconds: 150));
      await flutterTts.speak(text);
    } catch (e) {
      print("TTS speak error: $e");
    }
  }

  var speakingStatus = <String, RxBool>{}.obs;

  bool isSpeakingFor(String key) => speakingStatus[key]?.value ?? false;

  void setSpeaking(String key, bool value) {
    if (!speakingStatus.containsKey(key)) {
      speakingStatus[key] = false.obs;
    }
    speakingStatus[key]!.value = value;
  }

  void onSearchCourse([String? selectedCourse]) {
    final query = selectedCourse?.toLowerCase() ?? courseSearchController.text.toLowerCase();
    final allCourses = courseDayData;
    if (query.isNotEmpty) {
      filteredCourse.value = allCourses.where((course) {
        final dayString = "day ${course.dayNumber}".toLowerCase();
        return dayString.contains(query);
      }).toList();
    } else {
      filteredCourse.value = allCourses;
    }
    update(['course_list']);
  }

  void onSearchLesson([String? selectedLesson]) {
    final query = selectedLesson?.toLowerCase() ?? lessonSearchController.text.toLowerCase();
    final allLesson = lessonDaysData;

    if (query.isNotEmpty) {
      filteredLesson.value = allLesson.where((lesson) => lesson.title?.toLowerCase().contains(query) ?? false).toList();
    } else {
      filteredLesson.clear();
    }
    update();
  }

  Future<void> getCourseDayData(BuildContext context, [int? courseId]) async {
    try {
      isLoading.value = true;
      update(['loading', 'course_list']);
      errorMessage.value = '';
      final id = courseId ?? profileController.dashboardData.value?.course?.id ?? 0;
      debugPrint("✅ dashboard Course ID: ================$id");
      final response = await CourseDayService().callCourseDayService(context, id);
      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        courseDayData.value = response.responseData?.data ?? [];
        filteredCourse.value = courseDayData;
      } else {
        errorMessage.value = response.responseData?.message ?? 'Something went wrong';
        debugPrint("⚠️ Failed to fetch course data: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint("❌ Exception in getCourseDayData: $e");
    } finally {
      isLoading.value = false;
      update(['loading', 'course_list']);
    }
  }

  Future<void> fetchLessonContent(BuildContext context, int lessonId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await LessonContentService().callLessonContentService(context, lessonId);
      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        lessonContent.value = response.responseData?.data;
      } else {
        errorMessage.value = response.responseData?.message ?? 'Failed to fetch lesson content';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String getLessonStatus(LessonDaysData lesson, int index) {
    if (lesson.courseDay?.status != 'active') return 'none';
    if (index == 0) return 'resume';
    if (index < 3) return 'completed';
    return 'none';
  }

  Future<void> lessonCompleted(BuildContext context, int lessonId, var body) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await LessonCompletedService().callLessonCompletedService(context, lessonId, body);

      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: CustomText(
                  title: "🎉 Congratulations!",
                  textalign: TextAlign.center,
                  fontweight: FontWeight.bold,
                  fontsize: 20.sp),
              content: CustomText(
                  title: "You’ve successfully completed this lesson. Would you like to see all your completed lessons?",
                  textalign: TextAlign.left,
                  fontcolor: AppColor.blackColor,
                  fontsize: 16.sp),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: CustomRoundButton(
                        height: 35.h,
                        buttonColor: AppColor.whiteColor,
                        textColor: AppColor.blackColor,
                        onPress: () {
                          Get.back();
                          Get.back();
                        },
                        title: "Back",
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomRoundButton(
                        height: 35.h,
                        onPress: () {
                          Get.back();
                          Get.toNamed(RouteName.lessonCompleteScreen);
                        },
                        title: "Next",
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      } else {
        errorMessage.value = response.responseData?.message ?? 'Failed to complete lesson';
        Utils.toastMessage(context, errorMessage.value, true);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
