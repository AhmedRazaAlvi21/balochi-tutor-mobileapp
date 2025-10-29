import 'package:get/get.dart';

class SettingsController extends GetxController with GetSingleTickerProviderStateMixin {
  var allowNotifications = true.obs;
  var allowAppUpdates = false.obs;

  void toggleNotifications(bool value) {
    allowNotifications.value = value;
  }

  void toggleAppUpdates(bool value) {
    allowAppUpdates.value = value;
  }

  void updateSettings() {
    print("Allow Notifications: ${allowNotifications.value}");
    print("Allow App Updates: ${allowAppUpdates.value}");
  }
}
