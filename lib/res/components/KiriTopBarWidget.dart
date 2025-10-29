// import 'package:balochi_tutor/res/extensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../assets/custom_onboarding_bubble.dart';
// import '../assets/image_assets.dart';
// import '../colors/app_color.dart';
// import 'app_assets_image.dart';
// import 'custom_text.dart';
//
// class KiriTopBarWidget extends StatelessWidget {
//   final String title;
//
//   const KiriTopBarWidget({
//     super.key,
//     required this.title,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: context.blockSizeVertical * 20,
//       width: context.blockSizeHorizontal * 95,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 10.0,
//                 horizontal: 30.0,
//               ),
//               child: AppAssetsImage(
//                 imagePath: ImageAssets.happyLog2,
//                 width: 70.sp,
//                 height: 146.sp,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: CustomPaint(
//                 painter: OnboardingCustomPainter(),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0) + EdgeInsets.only(left: 30),
//                   child: CustomText(
//                     title: title,
//                     textalign: TextAlign.left,
//                     fontsize: 16.sp,
//                     fontcolor: AppColor.blackColor,
//                     fontweight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
