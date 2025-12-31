import 'package:balochi_tutor/service/notification_service/update_notification_service.dart';
import 'package:balochi_tutor/service/privacy_policy_service/privacy_policy_service.dart';
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
  final Map<String, String> _policyCache = {};
  var policy = RxnString();

  Future<void> fetchPrivacyPolicyData(BuildContext context, String slug) async {
    if (slug.isEmpty) {
      debugPrint("❌ Error: slug is empty");
      return;
    }
    if (_policyCache.containsKey(slug)) {
      policy.value = _policyCache[slug];
      debugPrint("✅ Loaded $slug from cache");
      return;
    }

    try {
      isLoading.value = true;
      final response = await PrivacyPolicyService().callPrivacyPolicyService(context, slug);
      final success = response.responseData?.success ?? false;
      final data = response.responseData?.data;
      if (success && data != null) {
        policy.value = data;
        _policyCache[slug] = data;
        debugPrint("📄 Cached $slug successfully");
      } else {
        Get.snackbar("Error", response.message ?? "Failed to load $slug");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool get hasNewNotification {
    if (notifications.isEmpty) return false;
    return notifications.first.id! > lastSeenNotificationId.value;
  }

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
