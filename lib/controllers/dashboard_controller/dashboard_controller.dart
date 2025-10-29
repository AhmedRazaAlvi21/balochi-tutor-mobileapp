import 'package:balochi_tutor/screens/dashboard/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/dashboard/course/course_screen.dart';
import '../../screens/dashboard/home_page/home_page.dart';

class DashboardController extends GetxController {
  int currentIndex = 0;
  final List<Widget> children = [HomePage(), CourseScreen(), SettingScreen()];

  void onTabTapped(int index) {
    currentIndex = index;
    update();
  }
}
