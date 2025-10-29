import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssetsImage extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;

  const AppAssetsImage({
    Key? key,
    required this.imagePath,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath.endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        fit: fit,
        width: width,
        height: height,
        color: color,
      );
    } else {
      return Image.asset(
        imagePath,
        fit: fit,
        width: width,
        height: height,
        color: color,
      );
    }
  }
}
