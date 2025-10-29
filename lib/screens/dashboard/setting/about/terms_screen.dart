import 'package:flutter/material.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/custom_text.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Center(
              child: CustomText(
                title: "No terms of service available at this time.",
                textalign: TextAlign.center,
                fontcolor: AppColor.blackColor,
                fontsize: 16,
              ),
            )),
      ),
    );
  }
}
