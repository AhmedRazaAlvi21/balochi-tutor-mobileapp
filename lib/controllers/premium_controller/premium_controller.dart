import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../service/payment_process_service/payment_process_service.dart';

class PremiumController extends GetxController {
  RxInt planId = 0.obs;
  RxString planPrice = ''.obs;
  RxString monthPlan = ''.obs;
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> allPremiumPlanData = <Map<String, dynamic>>[].obs;

  final picker = ImagePicker();
  RxMap<String, File?> selectedImages = <String, File?>{}.obs;

  @override
  void onInit() {
    super.onInit();
    allPremiumPlanData.value = [
      {
        'id': 1,
        'duration': '1 Month',
        'discount': 'Get over 10% off',
        'price': '\$10.00',
      },
      {
        'id': 2,
        'duration': '3 Months',
        'discount': 'Get over 20% off',
        'price': '\$26.00',
      },
      {
        'id': 3,
        'duration': '6 Months',
        'discount': 'Get over 30% off',
        'price': '\$46.00',
      },
      {
        'id': 4,
        'duration': '12 Months',
        'discount': 'Get over 40% off',
        'price': '\$86.00',
      },
    ];
  }

  Future<void> pickImageFromGallery(String methodName) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages[methodName] = File(pickedFile.path);
      selectedImages.refresh();
    }
  }

  void clearSelectedImage(String methodName) {
    selectedImages[methodName] = null;
    selectedImages.refresh();
  }

  /// ✅ Set selected plan (called when user selects a plan)
  void selectPlan(Map<String, dynamic> plan) {
    planId.value = plan['id'];
    monthPlan.value = plan['duration'];
    planPrice.value = plan['price'];
  }

  Future<void> confirmPayment({
    required BuildContext context,
    required String paymentSource,
  }) async {
    final screenshotPath = selectedImages[paymentSource]?.path;
    if (screenshotPath == null) {
      Get.snackbar("Error", "Please upload a payment screenshot first.");
      return;
    }

    if (monthPlan.isEmpty || planPrice.isEmpty) {
      Get.snackbar("Error", "Please select a subscription plan first.");
      return;
    }
    debugPrint("plane name ============= ${monthPlan.value}");
    debugPrint("paymentSource ============= $paymentSource");
    debugPrint("planPrice.value ============= ${planPrice.value}");
    debugPrint("paymentDate ============= ${DateTime.now().toIso8601String()}");
    debugPrint("screenshotPath ============= $screenshotPath");
    try {
      isLoading(true);
      final response = await PaymentProcessService().callPaymentProcessService(
        context: context,
        planName: monthPlan.value,
        paymentSource: paymentSource,
        price: planPrice.value,
        paymentDate: DateTime.now().toIso8601String(),
        screenshotPath: screenshotPath,
      );

      isLoading(false);

      if (response.responseData?.code == 200) {
        Get.snackbar(
          "Payment Confirmed",
          "Your payment for ${monthPlan.value} plan has been successfully submitted.",
          backgroundColor: Colors.white,
        );
        clearSelectedImage(paymentSource);
      } else {
        Get.snackbar("Failed", response.message ?? "Something went wrong");
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Error", e.toString());
    }
  }
}
