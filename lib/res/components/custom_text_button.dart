import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double fontsize;
  final double? borderRadius;
  final Color fontcolor;
  final Color? backgroundColor;
  final FontWeight fontweight;
  final TextAlign textalign;

  const CustomTextButton({
    required this.text,
    this.onPressed,
    this.fontsize = 18,
    this.fontcolor = const Color(0xFF6949FF),
    this.fontweight = FontWeight.normal,
    this.textalign = TextAlign.center,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(backgroundColor != null ? borderRadius ?? 10.0 : 0.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor ?? Colors.transparent,
        ),
      ),
      child: Text(
        text,
        textAlign: textalign,
        style: TextStyle(
          // textBaseline: TextBaseline.ideographic,
          fontWeight: fontweight,
          fontFamily: 'Nunito',
          color: fontcolor,
          fontSize: fontsize * context.textScaleFactorResponsive, // Use responsive font size
        ),
      ),
    );
  }
}
