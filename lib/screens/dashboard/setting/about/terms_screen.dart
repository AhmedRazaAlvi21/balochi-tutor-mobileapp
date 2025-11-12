import 'package:flutter/material.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/custom_text.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> termsList = [
      {
        'title': '1. Use of the Application',
        'desc':
            'You agree to use the app only for lawful purposes and in accordance with these Terms. You are responsible for maintaining the confidentiality of your account information.'
      },
      {
        'title': '2. Intellectual Property',
        'desc':
            'All content, features, and functionality of this app (including text, graphics, logos, and icons) are owned by the app developers and protected by copyright and trademark laws.'
      },
      {
        'title': '3. Limitation of Liability',
        'desc':
            'We are not liable for any indirect, incidental, or consequential damages arising from your use or inability to use this app. You use the app at your own risk.'
      },
      {
        'title': '4. Changes to Terms',
        'desc':
            'We reserve the right to modify or replace these Terms at any time. Continued use of the app after any changes constitutes your acceptance of the new Terms.'
      },
      {
        'title': '5. Contact Us',
        'desc': 'If you have any questions about these Terms, please contact us at support@example.com.'
      },
    ];

    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            title: 'Terms of Services',
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.center,
            fontsize: 20,
            fontweight: FontWeight.w700,
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: termsList.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: "Welcome to Our App!",
                    fontcolor: AppColor.blackColor,
                    fontsize: 18,
                    fontweight: FontWeight.w700,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    title:
                        "By using this app, you agree to comply with and be bound by the following terms and conditions.",
                    fontcolor: AppColor.blackColor,
                    fontsize: 14,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            } else if (index <= termsList.length) {
              final item = termsList[index - 1];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: item['title'] ?? '',
                      fontcolor: AppColor.blackColor,
                      fontsize: 16,
                      fontweight: FontWeight.w600,
                    ),
                    const SizedBox(height: 6),
                    CustomText(
                      title: item['desc'] ?? '',
                      fontcolor: AppColor.blackColor,
                      fontsize: 14,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CustomText(
                  title: "Last updated: November 2025",
                  fontcolor: AppColor.blackColor.withOpacity(0.6),
                  fontsize: 13,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
