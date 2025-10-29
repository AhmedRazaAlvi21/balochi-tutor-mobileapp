import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    getSavedThemeMode();
  }

  // GetStorage box = GetStorage();

  ThemeMode themeMode = ThemeMode.dark;

  Future<void> setThemeMode(ThemeMode theme) async {
    Get.changeThemeMode(theme);
    themeMode = theme;
    logininfo.put("theme", themeMode.toString().split('.')[1]);
    update();
  }

  getSavedThemeMode() async {
    var savedTheme = logininfo.get("theme") ?? "system";
    // import 'package:flutter/foundation.dart';for this
    themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == savedTheme);

    Get.changeThemeMode(themeMode);
    update();
  }
}
