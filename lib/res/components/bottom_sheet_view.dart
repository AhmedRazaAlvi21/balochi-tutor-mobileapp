import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/image_assets.dart';
import 'app_assets_image.dart';
import 'gradientButtonWidget/gradient_button_widget.dart';

class BottomSheetView extends StatelessWidget {
  final Color color;
  final String headertext;
  final String btntext;
  final VoidCallback btnOntap;

  const BottomSheetView({
    super.key,
    required this.color,
    required this.headertext,
    required this.btntext,
    required this.btnOntap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              headertext == "Correct"
                  ? AppAssetsImage(
                      imagePath: ImageAssets.leftFlower,
                      fit: BoxFit.scaleDown,
                      width: 45.w,
                      height: 45.h,
                    )
                  : Icon(Icons.warning_outlined, size: 30, color: AppColor.yellowColor),
              const SizedBox(width: 10),
              Text(
                headertext,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(width: 10),
              headertext == "Correct"
                  ? AppAssetsImage(
                      imagePath: ImageAssets.rightFlower,
                      fit: BoxFit.scaleDown,
                      width: 45.w,
                      height: 45.h,
                    )
                  : SizedBox(),
            ],
          ),
          const SizedBox(height: 30),
          GradientButtonWidget(title: btntext, onTap: btnOntap),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
