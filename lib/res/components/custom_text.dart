import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_color.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? fontsize;
  final Color fontcolor;
  final FontWeight fontweight;
  final TextAlign textalign;
  final int? maxline;
  final TextOverflow? overflow;

  CustomText({
    super.key,
    required this.title,
    this.fontsize,
    this.fontcolor = AppColor.primaryColor,
    this.fontweight = FontWeight.normal,
    this.textalign = TextAlign.start,
    this.maxline,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textalign,
      maxLines: maxline,
      overflow: overflow,
      style: GoogleFonts.nunito(
          //GoogleFonts.poppins
          // textBaseline: TextBaseline.ideographic,
          fontWeight: fontweight,
          // fontFamily: 'Poppins',
          color: fontcolor,
          fontSize: fontsize ?? 16.sp
          //fontSize: (fontsize * context.textScaleFactorResponsive), // Use responsive font size
          ),
    );
  }
}
