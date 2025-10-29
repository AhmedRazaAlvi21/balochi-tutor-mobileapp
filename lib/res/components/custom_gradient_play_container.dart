import 'package:balochi_tutor/res/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets/image_assets.dart';
import '../colors/app_color.dart';

class CustomCoursePlayContainer extends StatelessWidget {
  final String img;
  final VoidCallback ontap;
  final bool? showControls;

  const CustomCoursePlayContainer({super.key, required this.img, required this.ontap, this.showControls = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.orientation == Orientation.portrait
          ? context.blockSizeVertical * 30
          : context.blockSizeHorizontal * 30,
      width: context.blockSizeHorizontal * 100,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: ontap,
              child: Container(
                height: context.orientation == Orientation.portrait
                    ? context.blockSizeVertical * 30
                    : context.blockSizeHorizontal * 30,
                width: showControls! ? context.blockSizeHorizontal * 85 : context.blockSizeHorizontal * 90,
                decoration: BoxDecoration(
                    color: AppColor.greyColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(image: CachedNetworkImageProvider(img), fit: BoxFit.fill)),
                child: Center(
                  child: Image.asset(
                    ImageAssets.playIcon,
                    fit: BoxFit.scaleDown,
                    height: context.blockSizeHorizontal * 40,
                    width: context.blockSizeHorizontal * 40,
                  ),
                ),
              ),
            ),
          ),
          showControls!
              ? Padding(
                  padding: context.orientation == Orientation.portrait
                      ? const EdgeInsets.only(left: 0)
                      : const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomGradientCircle(
                      ontap: () {},
                      icon: Icons.arrow_back_ios,
                      isForward: false,
                    ),
                  ),
                )
              : Center(),
          showControls!
              ? Padding(
                  padding: context.orientation == Orientation.portrait
                      ? const EdgeInsets.only(right: 0)
                      : const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomGradientCircle(ontap: () {}, icon: Icons.arrow_forward_ios, isForward: true),
                  ),
                )
              : Center(),
        ],
      ),
    );
  }
}

class CustomGradientCircle extends StatelessWidget {
  final IconData icon;
  final bool isForward;
  final VoidCallback? ontap;
  final double? iconSize;

  const CustomGradientCircle({super.key, required this.icon, required this.isForward, this.ontap, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        // height: context.blockSizeHorizontal * 8,
        // width: context.blockSizeHorizontal * 8,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: isForward ? Alignment.centerRight : Alignment.centerLeft,
              end: isForward ? Alignment.centerLeft : Alignment.centerRight,
              colors: [
                Color(0XFF6949FF),
                Color(0XFFB09FFF),
              ]),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColor.whiteColor,
          size: iconSize ?? 19.0,
        ),
      ),
    );
  }
}
