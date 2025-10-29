import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/app_color.dart';
import '../custom_text.dart';

class CustomMissionContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progressVal;
  final String iconUrl;

  const CustomMissionContainer({
    super.key,
    required this.title,
    required this.progressVal,
    required this.iconUrl,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: context.blockSizeHorizontal * 15,
            child: Image.network(
              iconUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  fontcolor: AppColor.blackColor,
                  textalign: TextAlign.left,
                  fontsize: 18,
                  fontweight: FontWeight.w700,
                ),
                Row(
                  children: [
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 12.0, right: 10.0),
                    //     child: RoundedLinearProgressIndicator(
                    //       value: progressVal,
                    //       height: context.blockSizeVertical * 1.5,
                    //       backgroundColor: const Color(0xffEEEEEE),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomText(
                        title: subtitle,
                        fontcolor: AppColor.primaryColor,
                        textalign: TextAlign.center,
                        fontsize: 18,
                        fontweight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
