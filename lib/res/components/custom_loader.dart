import 'package:flutter/material.dart';

import '../colors/app_color.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;

  const CustomLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? AppColor.whiteColor,
    );
  }
}
