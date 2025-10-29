import 'package:balochi_tutor/res/components/round_button.dart';
import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors/app_color.dart';
import 'custom_divider.dart';
import 'custom_text.dart';

class LogoutWidget extends StatelessWidget {
  final VoidCallback yesOntap;

  const LogoutWidget({super.key, required this.yesOntap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.orientation == Orientation.portrait
          ? context.blockSizeVertical * 35
          : context.blockSizeHorizontal * 40,
      width: context.blockSizeHorizontal * 100,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(
            title: 'Logout',
            fontcolor: AppColor.redColor,
            textalign: TextAlign.left,
            fontsize: 24,
            fontweight: FontWeight.w600,
          ),
          CustomDivider(),
          CustomText(
            title: 'Are you sure you want to log out?',
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.left,
            fontsize: 20,
            fontweight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundButton(
                buttonColor: Color(0xffF0EDFF),
                text: CustomText(
                  title: 'cancel'.tr.toUpperCase(),
                  fontcolor: AppColor.primaryColor,
                  textalign: TextAlign.center,
                  fontsize: 14,
                  fontweight: FontWeight.w600,
                ),
                onPress: () {
                  Get.back();
                  // Get.toNamed(RouteName.ShareScreen);
                  // log('get started');
                },
                height: context.orientation == Orientation.portrait
                    ? context.blockSizeVertical * 7
                    : context.blockSizeHorizontal * 7,
                width: context.blockSizeHorizontal * 45,
              ),
              RoundButton(
                text: CustomText(
                  title: 'Yes, Logout',
                  fontcolor: AppColor.primaryTextColor,
                  textalign: TextAlign.center,
                  fontsize: 14,
                  fontweight: FontWeight.w600,
                ),
                onPress: yesOntap,
                height: context.orientation == Orientation.portrait
                    ? context.blockSizeVertical * 7
                    : context.blockSizeHorizontal * 7,
                width: context.blockSizeHorizontal * 45,
                boxshadow: [
                  BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
