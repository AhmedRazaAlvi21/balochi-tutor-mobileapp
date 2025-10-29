import 'package:balochi_tutor/res/assets/image_assets.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final ImageProvider? img;

  const BackgroundWidget({super.key, required this.child, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(image: DecorationImage(image: img ?? AssetImage(ImageAssets.background1), fit: BoxFit.fill)),
      child: child,
    );
  }
}
