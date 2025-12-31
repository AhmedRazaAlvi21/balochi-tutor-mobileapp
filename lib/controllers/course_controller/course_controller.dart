import 'package:audioplayers/audioplayers.dart';
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
import '../../res/assets/image_assets.dart';
import '../../res/components/app_assets_image.dart';
import '../../res/components/custom_rounded_button.dart';
import '../../service/course_service/lesson_content_service.dart';
import '../../utils/utils.dart';
import '../profile_controller/profile_controller.dart';

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
  final AudioPlayer audioPlayer = AudioPlayer();
  var selectedCourseId = 0.obs;

  /// Get quiz ID for a specific course day by calling getLessonDaysData
  /// This will return the quiz ID from the response when success is false
  Future<int> getQuizIdForCourseDay(BuildContext context, int courseDayId) async {
    try {
      debugPrint("🔍 Fetching quiz ID for course day: $courseDayId");
      final response = await LessonDaysService().callLessonDaysService(context, courseDayId);
      final responseData = response.responseData;

      // When success is false, quiz object is returned with quiz ID
      if (responseData?.success == false && responseData?.quiz != null) {
        final quizId = responseData!.quiz!.id ?? 0;
        debugPrint("✅ Found quiz ID: $quizId for course day: $courseDayId");
        return quizId;
      } else if (responseData?.code == 200 || responseData?.code == 201) {
        // If success is true, no quiz is required
        debugPrint("⚠️ No quiz required for course day: $courseDayId");
        return 0;
      } else {
        debugPrint("⚠️ No quiz found for course day: $courseDayId");
        return 0;
      }
    } catch (e) {
      debugPrint("❌ Error fetching quiz ID: $e");
      return 0;
    }
  }

  // Scroll position preservation
  final ScrollController courseScreenScrollController = ScrollController();
  final ScrollController lessonScreenScrollController = ScrollController();
  double _savedCourseScrollPosition = 0.0;
  double _savedLessonScrollPosition = 0.0;

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

  @override
  void onClose() {
    courseScreenScrollController.dispose();
    lessonScreenScrollController.dispose();
    super.onClose();
  }

  /// Save scroll position for CourseScreen
  void saveCourseScrollPosition() {
    if (courseScreenScrollController.hasClients) {
      _savedCourseScrollPosition = courseScreenScrollController.offset;
      debugPrint("💾 Saved CourseScreen scroll position: $_savedCourseScrollPosition");
    }
  }

  /// Restore scroll position for CourseScreen
  void restoreCourseScrollPosition() {
    if (_savedCourseScrollPosition > 0) {
      // Wait for the list to be built after data refresh
      Future.delayed(const Duration(milliseconds: 100), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (courseScreenScrollController.hasClients) {
            courseScreenScrollController.jumpTo(_savedCourseScrollPosition);
            debugPrint("📍 Restored CourseScreen scroll position: $_savedCourseScrollPosition");
          } else {
            // If controller not ready, try again after a short delay
            Future.delayed(const Duration(milliseconds: 200), () {
              if (courseScreenScrollController.hasClients) {
                courseScreenScrollController.jumpTo(_savedCourseScrollPosition);
                debugPrint("📍 Restored CourseScreen scroll position (delayed): $_savedCourseScrollPosition");
              }
            });
          }
        });
      });
    }
  }

  /// Save scroll position for LessonScreen
  void saveLessonScrollPosition() {
    if (lessonScreenScrollController.hasClients) {
      _savedLessonScrollPosition = lessonScreenScrollController.offset;
      debugPrint("💾 Saved LessonScreen scroll position: $_savedLessonScrollPosition");
    }
  }

  /// Restore scroll position for LessonScreen
  void restoreLessonScrollPosition() {
    if (_savedLessonScrollPosition > 0) {
      // Wait for the list to be built after data refresh
      Future.delayed(const Duration(milliseconds: 100), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (lessonScreenScrollController.hasClients) {
            lessonScreenScrollController.jumpTo(_savedLessonScrollPosition);
            debugPrint("📍 Restored LessonScreen scroll position: $_savedLessonScrollPosition");
          } else {
            // If controller not ready, try again after a short delay
            Future.delayed(const Duration(milliseconds: 200), () {
              if (lessonScreenScrollController.hasClients) {
                lessonScreenScrollController.jumpTo(_savedLessonScrollPosition);
                debugPrint("📍 Restored LessonScreen scroll position (delayed): $_savedLessonScrollPosition");
              }
            });
          }
        });
      });
    }
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
      } else if (responseData?.success == false) {
        debugPrint("responseData?.success == false");
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

  Future<void> playFromUrlOrTts(String? url, String text, {required String langType}) async {
    try {
      await flutterTts.stop();
      await audioPlayer.stop();
      if (_urlIsPlayable(url)) {
        await audioPlayer.play(UrlSource(url!));
      } else {
        await speak(text, langType: langType);
      }
    } catch (e) {
      print("❌ Audio play error: $e");
      await speak(text, langType: langType);
    }
  }

  bool _urlIsPlayable(String? url) {
    if (url == null) return false;
    if (url.trim().isEmpty) return false;
    if (url.trim() == "https://balochi.classicprogrammers.com/") return false;
    return url.endsWith(".mp3") || url.endsWith(".wav") || url.endsWith(".m4a") || url.endsWith(".aac");
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
        // Refresh dashboard data after lesson completion
        try {
          final profileController = Get.find<ProfileController>();
          await profileController.getDashboardData(context, forceRefresh: true);
        } catch (e) {
          debugPrint("⚠️ Could not refresh dashboard data: $e");
        }

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
                fontsize: 20.sp,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAssetsImage(
                    imagePath: ImageAssets.character,
                    fit: BoxFit.scaleDown,
                    height: 200.h,
                    width: 200.w,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    title: "This lesson is marked as completed!",
                    textalign: TextAlign.left,
                    fontcolor: AppColor.blackColor,
                    fontsize: 18.sp,
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Center(
                  child: CustomRoundButton(
                    height: 35.h,
                    onPress: () async {
                      Get.back();
                      Get.back();
                      print(
                          "courseController.selectedCourseId.value ============ ${courseController.selectedCourseId.value}");
                      await courseController.getLessonDaysData(context, courseController.selectedCourseId.value,
                          forceRefresh: true);
                      // Restore scroll position after data refresh
                      courseController.restoreLessonScrollPosition();
                    },
                    title: "OK",
                  ),
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

  // ========== QUIZ RELATED METHODS ==========
  bool isQuizDay(int day) {
    if (day == 1) return false;
    return (day - 1) % 7 == 0;
  }

  int getQuizNumber(int day) {
    return ((day - 1) / 7).floor();
  }

  int getQuizDay(int quizNumber) {
    return (quizNumber * 7) + 1;
  }

  bool isQuizDayUnlocked(int quizNum, List<CourseDaysData> courseList) {
    int quizDay = getQuizDay(quizNum);
    for (var c in courseList) {
      final cDay = c.dayNumber ?? 0;
      if (cDay == quizDay) {
        return c.isLocked == false;
      }
    }
    return false;
  }

  bool isQuizNextDayUnlocked(int quizNum, List<CourseDaysData> courseList) {
    int nextQuizNum = quizNum + 1;
    int nextQuizDay = getQuizDay(nextQuizNum);
    debugPrint("🔍 Checking Quiz $quizNum completion: nextQuizNum=$nextQuizNum, nextQuizDay=$nextQuizDay");
    for (var c in courseList) {
      final cDay = c.dayNumber ?? 0;
      if (cDay == nextQuizDay) {
        bool isUnlocked = c.isLocked == false;
        debugPrint("   ✅ Found day $nextQuizDay: isLocked=${c.isLocked}, Quiz $quizNum completed=$isUnlocked");
        return isUnlocked;
      }
    }
    debugPrint("   ❌ Day $nextQuizDay not found in courseList, Quiz $quizNum NOT completed");
    return false;
  }

  int? getHighestCompletedQuiz(List<CourseDaysData> courseList) {
    int maxQuiz = 50; // Reasonable max
    for (int q = maxQuiz; q >= 1; q--) {
      if (isQuizNextDayUnlocked(q, courseList)) {
        debugPrint("   🎯 Highest completed quiz found: $q");
        return q;
      }
    }
    return null;
  }

  int? getFirstLockedDay(List<CourseDaysData> courseList) {
    for (int i = 0; i < courseList.length; i++) {
      var c = courseList[i];
      if (c.isLocked == true) {
        return c.dayNumber ?? (i + 1);
      }
    }
    return null;
  }

  bool isQuizCompleted(int quizNumber, List<CourseDaysData> courseList) {
    int quizDay = getQuizDay(quizNumber);
    for (var c in courseList) {
      if (c.dayNumber == quizDay) {
        return c.isLocked == false;
      }
    }
    return false;
  }

  bool shouldShowStartQuizButton(int quizNumber, int? firstLockedDay, List<CourseDaysData> courseList) {
    if (firstLockedDay == null) return false;
    int firstLockedQuiz = getQuizNumber(firstLockedDay);
    bool completed = isQuizCompleted(quizNumber, courseList);
    return quizNumber == firstLockedQuiz && !completed;
  }

  /// Clear all course-related data when logging out or switching users
  void clearCourseData() {
    debugPrint("🧹 Clearing course data from CourseController...");
    
    // Clear reactive lists
    lessonDaysData.clear();
    completedLessonsData.clear();
    filteredLesson.clear();
    courseDayData.clear();
    filteredCourse.clear();
    lessonContent.value = null;
    
    // Reset flags
    isCourseDayDataFetched.value = false;
    isLessonDayDataFetched.value = false;
    isLoading.value = false;
    errorMessage.value = '';
    hasFetchedCompletedLessons = false;
    isDropdownExpanded.value = false;
    
    // Reset other values
    selectedCourse.value = "";
    selectedLesson.value = "";
    quizId = 0;
    completedQuizNumber.value = 0;
    selectedCourseId.value = 0;
    
    // Clear text controllers
    courseSearchController.clear();
    lessonSearchController.clear();
    
    // Reset scroll positions
    _savedCourseScrollPosition = 0.0;
    _savedLessonScrollPosition = 0.0;
    
    debugPrint("✅ Course data cleared successfully");
  }
}
