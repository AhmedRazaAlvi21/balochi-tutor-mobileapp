import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/custom_text.dart';

class CourseCompleteWidget extends StatelessWidget {
  final String? title;
  final String? lesson;
  final String? lessonNo;
  final String? image;

  const CourseCompleteWidget({super.key, this.title, this.lessonNo, this.lesson, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColor.whiteColor,
          border: Border.all(color: AppColor.whiteColor2)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AppAssetsImage(
                          imagePath: image ?? ImageAssets.courseImage,
                          height: 100.h,
                          width: 100.w,
                        )),
                    Positioned(
                        top: 10, bottom: 0, left: 10, right: 0, child: AppAssetsImage(imagePath: ImageAssets.playIcon))
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            title: title ?? "lesson 1",
                            fontcolor: AppColor.black121,
                            textalign: TextAlign.left,
                            fontsize: 18.sp,
                            fontweight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                            maxline: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: AppAssetsImage(
                              imagePath: ImageAssets.downIcon,
                              fit: BoxFit.scaleDown,
                              width: 12.w,
                              height: 10.h,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColor.whiteColor2,
                        thickness: 2,
                      ),
                      CustomText(
                        title: lessonNo ?? "Day 1",
                        fontcolor: AppColor.black121,
                        textalign: TextAlign.left,
                        fontsize: 18.sp,
                        fontweight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                        maxline: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        title: lesson ?? "40 Lesson",
                        fontcolor: AppColor.blackColor,
                        textalign: TextAlign.left,
                        fontweight: FontWeight.w500,
                        fontsize: 12.sp,
                        maxline: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(height: 10.h),
            // CustomText(
            //   title: title ?? "lesson 1",
            //   fontcolor: AppColor.black121,
            //   textalign: TextAlign.left,
            //   fontsize: 18.sp,
            //   fontweight: FontWeight.w700,
            //   overflow: TextOverflow.ellipsis,
            //   maxline: 1,
            // ),
            // SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
