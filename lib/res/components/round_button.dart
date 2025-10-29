import 'package:flutter/material.dart';

import '../colors/app_color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {Key? key,
      this.buttonColor,
      required this.text,
      required this.onPress,
      this.width = 60,
      this.height = 50,
      this.loading = false,
      this.boxshadow,
      this.borderWidth = 0.0,
      this.borderColor = Colors.transparent,
      this.borderRadius})
      : super(key: key);

  final bool loading;
  final Widget text;
  final double height, width;
  final double? borderWidth;
  final VoidCallback? onPress;
  final Color? buttonColor;
  final Color? borderColor;
  final List<BoxShadow>? boxshadow;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return
        // MaterialButton(
        //   onPressed: onPress,
        //   child: loading
        //       ? Center(child: CircularProgressIndicator())
        //       : Center(child: text),
        //   color: buttonColor,
        //   height: height,
        //   minWidth: width,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        // );
        InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor!,
              width: borderWidth!,
            ),
            boxShadow: boxshadow,
            // color: buttonColor,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: buttonColor == Color(0xffF0EDFF) || buttonColor == AppColor.whiteColor
                  ? [
                      Color(0xffF0EDFF),
                      Color.fromARGB(255, 230, 224, 238),
                    ]
                  : [
                      Color(0xffB09FFF),
                      Color(0xff6949FF),
                    ],
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(50)),
        child: loading ? Center(child: CircularProgressIndicator()) : Center(child: text),
      ),
    );
  }
}
