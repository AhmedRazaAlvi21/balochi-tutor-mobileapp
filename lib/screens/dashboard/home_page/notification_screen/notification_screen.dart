import 'package:balochi_tutor/controllers/settings_controller/settings_controller.dart';
import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/components/background_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    controller.fetchNotifications(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.markAllAsSeen();
    });
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: CustomText(
            title: "Notifications",
            fontcolor: AppColor.blackColor,
            fontsize: 24.sp,
            fontweight: FontWeight.w700,
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_off, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    "No notifications yet",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12.sp),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final item = controller.notifications[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12.sp),
                padding: EdgeInsets.all(14.sp),
                decoration: BoxDecoration(
                  color: AppColor.primary3,
                  borderRadius: BorderRadius.circular(12.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: item.title ?? "Title",
                      fontsize: 18.sp,
                      fontweight: FontWeight.w700,
                      fontcolor: AppColor.blackColor,
                    ),
                    SizedBox(height: 6.sp),
                    CustomText(
                      ////
                      title: item.body ?? "Description",
                      fontsize: 14.sp,
                      fontcolor: AppColor.blackColor,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: CustomText(
                            title: formatLocalTime(item.createdAt.toString()),
                            fontsize: 12.sp,
                            fontcolor: AppColor.blackColor)),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }

  String formatLocalTime(String utcString) {
    try {
      DateTime utcTime = DateTime.parse(utcString);
      DateTime localTime = utcTime.toLocal();
      return "${localTime.hour.toString().padLeft(2, '0')}:"
          "${localTime.minute.toString().padLeft(2, '0')} :"
          "${localTime.day}-${localTime.month}-${localTime.year}";
    } catch (e) {
      return utcString;
    }
  }
}
