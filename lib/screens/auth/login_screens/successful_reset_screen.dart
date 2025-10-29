// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:learnkad_language_app/res/components/background_widget.dart';
// import 'package:learnkad_language_app/res/components/round_button.dart';
// import 'package:learnkad_language_app/res/extensions.dart';
// import 'package:learnkad_language_app/res/routes/routes_name.dart';
//
// import '../../../res/assets/custom_bubble_shape.dart';
// import '../../../res/assets/image_assets.dart';
// import '../../../res/colors/app_color.dart';
// import '../../../res/components/custom_text.dart';
//
// class SuccessfulResetScreen extends StatelessWidget {
//   const SuccessfulResetScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: BackgroundWidget(
//         // painter: LanguageLearningBackgroundPainter(),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   SizedBox(
//                     height: context.orientation == Orientation.portrait
//                         ? context.blockSizeVertical * 12
//                         : context.blockSizeHorizontal * 5,
//                   ),
//                   CustomPaint(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         bottom: 20.0,
//                         right: 50.0,
//                         left: 50.0,
//                         top: 5.0,
//                       ),
//                       child: CustomText(
//                         title: 'hurray'.tr,
//                         fontcolor: AppColor.blackColor,
//                         fontsize: 20,
//                         fontweight: FontWeight.w700,
//                       ),
//                     ),
//                     // size: Size(
//                     //     context.blockSizeHorizontal * 60,
//                     //     (context.blockSizeHorizontal * 50 * 0.32)
//                     //         .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//                     painter: RPSCustomPainter(),
//                   ),
//                   SizedBox(
//                     height: context.blockSizeVertical * 5,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 35.0,
//                       horizontal: 30.0,
//                     ),
//                     child: Image.asset(
//                       ImageAssets.excited_kiri,
//                       fit: BoxFit.scaleDown,
//                       height: 200,
//                       width: 200,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15.0,
//                       vertical: 5.0,
//                     ),
//                     child: CustomText(
//                       title: 'Welcome 👋',
//                       fontcolor: AppColor.primaryColor,
//                       textalign: TextAlign.center,
//                       fontsize: 34.sp,
//                       fontweight: FontWeight.w700,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15.0,
//                       vertical: 10.0,
//                     ),
//                     child: CustomText(
//                       title: 'reset_msg'.tr,
//                       fontcolor: AppColor.greyColor,
//                       textalign: TextAlign.center,
//                       fontsize: 20.sp,
//                       fontweight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(
//                     height: context.blockSizeVertical * 12,
//                   ),
//                   RoundButton(
//                     text: CustomText(
//                       title: 'continue_to_home'.tr,
//                       fontcolor: AppColor.primaryTextColor,
//                       textalign: TextAlign.center,
//                       fontsize: 16,
//                       fontweight: FontWeight.bold,
//                     ),
//                     onPress: () {
//                       Get.toNamed(RouteName.LoginScreen);
//                       // log('get started');
//                     },
//                     height: context.orientation == Orientation.portrait
//                         ? context.blockSizeVertical * 7
//                         : context.blockSizeHorizontal * 7,
//                     width: context.blockSizeHorizontal * 85,
//                     boxshadow: [
//                       BoxShadow(
//                         color: AppColor.primaryColor.withOpacity(0.5),
//                         spreadRadius: 0.1,
//                         blurRadius: 10,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: context.blockSizeVertical * 5,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
