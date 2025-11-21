import 'dart:io';

import 'package:balochi_tutor/models/get_dashboard_model/get_dashboard_response_model.dart';
import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:balochi_tutor/service/auth_service/logout_service.dart';
import 'package:balochi_tutor/service/dashboard_service/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../../models/user_profile_model/user_profile_response_model.dart';
import '../../res/assets/image_assets.dart';
import '../../service/user_profile_service/get_user_profile_Service.dart';
import '../../service/user_profile_service/user_profile_update_service.dart';
import '../../utils/utils.dart';
import '../course_controller/course_controller.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController DOBController = TextEditingController();
  final TextEditingController CountryController = TextEditingController();
  var userProfileData = Rxn<UserProfileData>();
  var dashboardData = Rxn<DashboardData>();
  var userId = 0;
  var isLoading = false.obs;

  var errorMessage = ''.obs;
  var isDataFetched = false.obs;
  var isDashboardFetched = false.obs;
  DateTime? selectedDate;
  Rx<File?> userImg = Rx<File?>(null);
  RxBool isLoggingOut = false.obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        userImg.value = File(pickedFile.path);
        updateUserProfileImage(File(pickedFile.path));
      } else {
        print("No image selected");
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> updateUserProfileImage(File image) async {
    try {
      print("Image updated successfully: ${image.path}");
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      debugPrint("Error updating profile image: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Don't call context here (it's null)
    _initializeData();
  }

  @override
  void onReady() {
    super.onReady();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final context = Get.context;
    await getUserProfileData(context!);
    await getDashboardData(context);
    final courseId = dashboardData.value?.course?.id;
    if (courseId != null) {
      final courseController = Get.put(CourseController());
      await courseController.getCourseDayData(context);
    } else {
      debugPrint("No course ID found in dashboard data — skipping course fetch");
    }
  }

  Future<void> getUserProfileData(BuildContext context) async {
    if (isDataFetched.value) {
      print("✅ Profile data already fetched — skipping API call");
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await UserProfileService().callUserProfileService(context);

      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        //Utils.toastMessage(context, "${response.responseData?.message}", true);
        userProfileData.value = response.responseData?.data;

        nameController.text = response.responseData?.data?.name ?? '';
        phoneNumberController.text = response.responseData?.data?.phoneNo ?? '';
        emailController.text = response.responseData?.data?.email ?? '';
        CountryController.text = response.responseData?.data?.country ?? '';
        DOBController.text = response.responseData?.data?.dob ?? '';

        final imageUrl = response.responseData?.data?.userImg;
        if (imageUrl != null && imageUrl.isNotEmpty) {
          print("🖼️ Profile image URL from API: $imageUrl");
          userProfileData.value?.userImg = imageUrl;
        }
        isDataFetched.value = true;
      } else {
        errorMessage.value = response.responseData?.message ?? 'Something went wrong';
        //Utils.toastMessage(context, errorMessage.value, false);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      //Utils.toastMessage(context, errorMessage.value, false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDashboardData(BuildContext context) async {
    // if (isDashboardFetched.value) {
    //   print("Profile data already fetched — skipping API call");
    //   return;
    // }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await DashboardService().callDashboardService(context);

      if (response.responseData?.code == 200 || response.responseData?.code == 201) {
        dashboardData.value = response.responseData?.data;
        userId = response.responseData?.data?.course?.id ?? 0;
        print("user id ================== ${userId}");
        isDashboardFetched.value = true;
      } else {
        errorMessage.value = response.responseData?.message ?? 'Something went wrong';
        //Utils.toastMessage(context, errorMessage.value, false);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      //Utils.toastMessage(context, errorMessage.value, false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> userProfileUpdate(BuildContext context) async {
    loadingController.setLoading(true);
    try {
      var response = await UserProfileUpdateService().callUserProfileUpdateService(context);

      if (response.responseData?.success == true) {
        Get.snackbar(
          "Success",
          response.responseData?.message ?? "Profile updated successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        var profileResponse = await UserProfileService().callUserProfileService(context);
        if (profileResponse.responseData?.success == true && profileResponse.responseData?.data != null) {
          userProfileData.value = profileResponse.responseData?.data;
          Get.back();
        } else {
          errorMessage.value = profileResponse.responseData?.message ?? 'Failed to fetch user profile';
          Get.snackbar("Error", errorMessage.value, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("Error", response.responseData?.message ?? "Profile update failed");
      }
    } catch (error) {
      Get.snackbar("Error", "An error occurred: $error");
    } finally {
      loadingController.setLoading(false);
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime tenYearsAgo = DateTime(today.year - 10, today.month, today.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: tenYearsAgo.subtract(const Duration(days: 365 * 10)),
      firstDate: DateTime(1920),
      lastDate: tenYearsAgo,
    );

    if (pickedDate != null) {
      DOBController.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  Future<bool> userLogout(BuildContext context) async {
    print("📤 Calling Logout API...");
    isLoggingOut.value = true;

    try {
      final response = await LogoutService().callLogoutService(context);

      if (response.responseData?.success == true) {
        Utils.toastMessage(context, "${response.responseData?.message}", true);
        return true;
      } else {
        Utils.toastMessage(context, response.responseData?.message ?? "Logout failed", false);
        return false;
      }
    } catch (e) {
      Utils.toastMessage(context, "Logout error", false);
      return false;
    } finally {
      isLoggingOut.value = false; // STOP LOADING
    }
  }

  List settingsOptions = [
    {
      'name': 'Personal Info',
      'img': ImageAssets.personal,
      "ontap": () {
        Get.toNamed(RouteName.personalInfo);
      },
    },
    {
      'name': 'Notifications',
      'img': ImageAssets.billIcon,
      "ontap": () {
        Get.toNamed(RouteName.notifications);
      },
    },
    {
      'name': 'About',
      'img': ImageAssets.about,
      "ontap": () {
        Get.toNamed(RouteName.aboutScreen);
      },
    },
    {
      'name': 'Logout',
      'img': ImageAssets.logOut,
      "ontap": () {},
    },
  ];
}
