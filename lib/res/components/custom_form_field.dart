import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_color.dart';

class CustomFormField extends StatelessWidget {
  String title;
  int maxLines;
  int minLines;
  String? labelText;
  TextEditingController fieldcontroller;

  // final FocusNode focusnode;
  final List<Color> gradientcolors;

  // final bool isgradientborder;
  final bool ispassword;
  final bool? readonly;
  final bool? isFilled;
  final onchange;
  final validator;
  final onsaved;
  final ontap;
  final TextInputType keyboardtype;
  final Widget? sIcon;
  final Widget? pIcon;
  Color bgColor;
  Color fgColor;
  Color bdColor;
  double bottomLeftRadius;
  double topLeftRadius;
  double bottomRightRadius;
  double topRightRadius;
  double? width;
  double? height;
  double? fontsize;
  double bdwidth;
  TextStyle? hintStyle;
  final Color? fontColor;
  final InputBorder? border;
  FocusNode? focusNode;

  CustomFormField({
    super.key,
    required this.title,
    // this.isgradientborder = true,
    this.ispassword = false,
    this.onchange,
    this.validator,
    this.onsaved,
    // required this.focusnode,
    this.keyboardtype = TextInputType.text,
    this.gradientcolors = const [Colors.red, Colors.blue],
    this.bgColor = AppColor.whiteColor,
    this.fgColor = AppColor.blackColor,
    this.bdColor = AppColor.greyColor,
    required this.fieldcontroller,
    this.bottomLeftRadius = 0.0,
    this.bottomRightRadius = 0.0,
    this.topLeftRadius = 0.0,
    this.topRightRadius = 0.0,
    this.height,
    this.width,
    this.hintStyle,
    this.fontsize,
    this.bdwidth = 2.0,
    this.sIcon,
    this.readonly = false,
    this.fontColor = AppColor.blackColor,
    this.border,
    this.isFilled = false,
    this.pIcon,
    this.labelText,
    this.maxLines = 1,
    this.minLines = 1,
    this.ontap,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldcontroller,
      onChanged: onchange,
      readOnly: readonly!,
      maxLines: maxLines,
      onTap: ontap,
      minLines: minLines,
      focusNode: focusNode,
      // focusNode: focusnode,
      onFieldSubmitted: onsaved as Function(String?)?,
      textAlign: TextAlign.left,
      obscureText: ispassword,
      keyboardType: keyboardtype,
      cursorColor: Color(0xFF856CF3),

      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: GoogleFonts.roboto(
        // textBaseline: TextBaseline.ideographic,
        fontWeight: FontWeight.w500,

        color: fontColor,

        fontSize: (fontsize ?? 20) * context.textScaleFactorResponsive, // Use responsive font size
      ),

      decoration: InputDecoration(
        fillColor: bgColor,
        filled: isFilled,
        suffixIcon: sIcon,
        prefixIcon: pIcon,
        hintStyle: hintStyle ?? TextStyle(color: AppColor.greyColor1),
        hintText: title,
        labelText: labelText,
        disabledBorder: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                width: 1,
              ),
            ),
        enabledBorder: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                width: 1,
              ),
            ),
        border: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                width: 1,
              ),
            ),
        errorBorder: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                width: 1,
              ),
            ),
        prefixIconColor: AppColor.greyColor,
        focusedBorder: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                width: 1,
              ),
            ),
      ),
    );
  }
}
