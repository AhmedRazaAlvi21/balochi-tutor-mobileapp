import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/settings_controller/settings_controller.dart';
import '../../../../res/components/background_widget.dart';

class PolicyScreen extends StatefulWidget {
  final String slug;
  final String title;

  const PolicyScreen({required this.slug, required this.title, super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  final controller = Get.find<SettingsController>();

  @override
  void initState() {
    super.initState();
    controller.fetchPrivacyPolicyData(context, widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final policyText = controller.policy.value;

          if (policyText == null || policyText.isEmpty) {
            return Center(child: Text("No ${widget.title} found"));
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: SingleChildScrollView(
              child: buildDescription(policyText),
            ),
          );
        }),
      ),
    );
  }

  Widget buildDescription(String? description) {
    if (description == null || description.isEmpty) {
      return const Text(
        "No description available.",
        style: TextStyle(fontSize: 16, color: Colors.black87),
      );
    }
    final bool isHtml = RegExp(r"<[^>]+>").hasMatch(description);
    if (isHtml) {
      return Html(
        data: description,
        style: {
          "body": Style(
            fontSize: FontSize(12.sp),
            lineHeight: LineHeight(1.5),
            color: Colors.black87,
          ),
          "h4": Style(
            fontWeight: FontWeight.bold,
            fontSize: FontSize(18.sp),
          ),
          "p": Style(
            margin: Margins.only(bottom: 7),
          ),
        },
      );
    } else {
      return Text(
        description,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black87,
          height: 1.5,
        ),
      );
    }
  }
}
