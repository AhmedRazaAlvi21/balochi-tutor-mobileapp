import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void callUnFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
