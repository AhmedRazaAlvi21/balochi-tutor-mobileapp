import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/image_assets.dart';
import '../../colors/app_color.dart';

class GradientTextWidget extends StatelessWidget {
  final double? width;
  final Widget child;
  final EdgeInsets? padding;
  final List<Color>? gradientColors;

  const GradientTextWidget({super.key, this.width, required this.child, this.padding, this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors ?? AppColor.gradientButton,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        IntrinsicWidth(
          child: Container(
            width: width,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              gradient: LinearGradient(
                colors: gradientColors ?? AppColor.gradientButton,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                image: DecorationImage(
                  image: AssetImage(ImageAssets.background1),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(child: child),
            ),
          ),
        ),

        /// Right Gradient Line
        Expanded(
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors ?? AppColor.gradientButton,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
