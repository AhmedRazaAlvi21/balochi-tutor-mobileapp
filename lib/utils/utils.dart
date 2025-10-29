import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../res/colors/app_color.dart';
import '../res/components/custom_confirmation_dialog.dart';

class Utils {
  static Future<bool> onwillPopFunc(BuildContext context) async {
    customConfirmationDiaglog(context, 'areYouSureYouWantToExit'.tr, 'yes'.tr, 'no'.tr, () {
      if (dashboardController.currentIndex == 0) {
        SystemNavigator.pop();
        Navigator.pop(context);
      } else {
        dashboardController.onTabTapped(0);
        Navigator.pop(context);
      }
    });
    return false;
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void toastMessage(BuildContext context, String message, bool success) {
    BuildContext? currentContext = context ?? Get.context;
    if (currentContext != null) {
      Flushbar(
        message: message,
        backgroundColor: success ? AppColor.greenColor1 : AppColor.redColor,
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        icon: Icon(
          success ? Icons.check_circle : Icons.error,
          color: Colors.white,
        ),
      ).show(currentContext);
    } else {
      debugPrint("Unable to show toast message. No valid context provided.");
    }
  }

  static void toastMessageBottom(BuildContext context, String message, bool success) {
    BuildContext? currentContext = context ?? Get.context;
    if (currentContext != null) {
      Flushbar(
        message: message,
        backgroundColor: success ? AppColor.greenColor1 : AppColor.redColor,
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.BOTTOM,
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        icon: Icon(
          success ? Icons.check_circle : Icons.error,
          color: Colors.white,
        ),
      ).show(currentContext);
    } else {
      debugPrint("Unable to show toast message.");
    }
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  static Future<bool> onWillNavigate(BuildContext context, Function() onTap) async {
    customConfirmationDiaglog(
        context,
        'Are you sure you want to go back?'.tr, // Confirmation message
        'Yes'.tr,
        'No'.tr,
        onTap);

    return false; // Prevent default back action
  }

  String formatDate(String dateString, {String? format}) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      String formattedDate = DateFormat(format ?? 'dd MMMM yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return 'Unknown date';
    }
  }
}
