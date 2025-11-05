import 'package:flutter/material.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/custom_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            title: 'Privacy Policy',
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.center,
            fontsize: 20,
            fontweight: FontWeight.w700,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: "Last Updated: October 2025",
                  fontcolor: AppColor.blackColor,
                  fontsize: 14,
                  fontweight: FontWeight.w500,
                ),
                const SizedBox(height: 20),
                CustomText(
                  title:
                      "Welcome to our application. This Privacy Policy explains how we collect, use, and protect your personal information when you use our services.",
                  fontcolor: AppColor.blackColor,
                  fontsize: 16,
                ),
                const SizedBox(height: 20),
                CustomText(
                  title: "1. Information We Collect",
                  fontcolor: AppColor.blackColor,
                  fontsize: 18,
                  fontweight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                CustomText(
                  title:
                      "We may collect information such as your name, email address, and app usage data to provide a better user experience.",
                  fontcolor: AppColor.blackColor,
                  fontsize: 16,
                ),
                const SizedBox(height: 20),
                CustomText(
                  title: "2. How We Use Your Information",
                  fontcolor: AppColor.blackColor,
                  fontsize: 18,
                  fontweight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                CustomText(
                  title:
                      "The information collected is used to improve app performance, enhance content, and ensure personalized user experiences.",
                  fontcolor: AppColor.blackColor,
                  fontsize: 16,
                ),
                const SizedBox(height: 20),
                CustomText(
                  title: "3. Data Security",
                  fontcolor: AppColor.blackColor,
                  fontsize: 18,
                  fontweight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                CustomText(
                  title:
                      "We use standard security practices to protect your data. However, please note that no method of transmission over the internet is 100% secure.",
                  fontcolor: AppColor.blackColor,
                  fontsize: 16,
                ),
                const SizedBox(height: 20),
                CustomText(
                  title: "4. Third-Party Services",
                  fontcolor: AppColor.blackColor,
                  fontsize: 18,
                  fontweight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                CustomText(
                  title:
                      "Our app may contain links to third-party websites or services that are not operated by us. We recommend reviewing their privacy policies separately.",
                  fontcolor: AppColor.blackColor,
                  fontsize: 16,
                ),
                const SizedBox(height: 20),
                CustomText(
                  title: "5. Changes to This Policy",
                  fontcolor: AppColor.blackColor,
                  fontsize: 18,
                  fontweight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                CustomText(
                  title:
                      "We may update this Privacy Policy periodically. You are encouraged to review it regularly for any changes.",
                  fontcolor: AppColor.blackColor,
                  fontsize: 16,
                ),
                const SizedBox(height: 20),
                CustomText(
                  title: "6. Contact Us",
                  fontcolor: AppColor.blackColor,
                  fontsize: 18,
                  fontweight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                CustomText(
                  title:
                      "If you have any questions or concerns about this Privacy Policy, please contact us at support@example.com.",
                  fontcolor: AppColor.blackColor,
                  fontsize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
