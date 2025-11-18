import 'package:balochi_tutor/service/notification_service/update_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/notification_model/get_notifications_response_model.dart';
import '../../service/notification_service/get_notification_service.dart';

class SettingsController extends GetxController with GetSingleTickerProviderStateMixin {
  var allowNotifications = true.obs;
  var allowAppUpdates = false.obs;
  var notifications = <GetNotificationData>[].obs;
  var isLoading = false.obs;
  var lastSeenNotificationId = 0.obs;

  bool get hasNewNotification {
    if (notifications.isEmpty) return false;
    return notifications.first.id! > lastSeenNotificationId.value;
  }
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchNotifications(Contect);
  // }

  void toggleNotifications(bool value) {
    allowNotifications.value = value;
  }

  Future<void> fetchNotifications(BuildContext context) async {
    final context = Get.context!;
    try {
      isLoading.value = true;
      final response = await GetNotificationService().callGetNotificationService(context);
      if (response.responseData?.success == true) {
        notifications.value = response.responseData?.data ?? [];
      } else {
        Get.snackbar("Error", response.responseData?.message ?? "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNotification(BuildContext context) async {
    try {
      var response = await UpdateNotificationService().callUpdateNotificationService(context);

      if (response.responseData?.success == true) {
        allowNotifications.value = response.responseData!.data!.allowNotifications ?? false;

        Get.snackbar("Success", response.responseData?.message ?? "Updated");
      } else {
        Get.snackbar("Error", response.responseData?.message ?? "Update failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void markAllAsSeen() {
    if (notifications.isNotEmpty) {
      lastSeenNotificationId.value = notifications.first.id!;
    }
  }
}
