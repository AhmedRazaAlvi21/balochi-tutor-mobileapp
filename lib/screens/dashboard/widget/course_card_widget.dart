import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/custom_text.dart';

class CourseCardWidget extends StatelessWidget {
  final bool? done;
  final String? title;
  final String? subTitle;
  final String? lesson;
  final String? words;
  final String? image;

  const CourseCardWidget({super.key, this.done, this.title, this.subTitle, this.lesson, this.words, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColor.whiteColor,
          border: Border.all(color: AppColor.whiteColor2)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
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
                  Divider(
                    color: AppColor.whiteColor2,
                    thickness: 2,
                  ),
                  CustomText(
                    title: title ?? "Day 1",
                    fontcolor: AppColor.black121,
                    textalign: TextAlign.left,
                    fontsize: 18.sp,
                    fontweight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    maxline: 1,
                  ),
                  CustomText(
                    title: subTitle ?? "Balochi",
                    fontcolor: AppColor.black161,
                    textalign: TextAlign.left,
                    fontweight: FontWeight.w500,
                    fontsize: 14.sp,
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
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    title: words ?? "400 words",
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
            done == true
                ? Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: AppAssetsImage(
                      imagePath: ImageAssets.done,
                      height: 46.h,
                      width: 46.w,
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
