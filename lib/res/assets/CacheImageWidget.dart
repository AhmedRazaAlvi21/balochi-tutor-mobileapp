import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'image_assets.dart';

Widget cacheImageWidget(String? url, double? width, double? height, BoxFit boxFit,
    {Color? imageColor,
    Color? svgColor,
    bool showLoadingShimmers = true,
    bool showLoading = true,
    bool showErrorWidget = true,
    Color? svgBackgroundColor,
    shimmerBackgroundColor,
    Alignment alignment = Alignment.center,
    BoxFit? svgBoxFit}) {
  if (url == null || url.isEmpty) {
    return Image.asset(
      ImageAssets.person1,
      height: height,
      width: width,
      fit: boxFit,
    );
  }
  return CachedNetworkImage(
    fit: boxFit,
    imageUrl: url,
    width: width,
    alignment: alignment,
    color: imageColor,
    height: height,
    progressIndicatorBuilder: (context, url, downloadProgress) {
      return showLoading
          ? showLoadingShimmers
              ? Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey,
                  child: Container(
                    alignment: Alignment.center,
                    color: shimmerBackgroundColor ?? Colors.grey,
                    child: Text("Loading..."),
                  ),
                )
              : Center(child: CircularProgressIndicator())
          : SizedBox();
    },
    errorWidget: (context, url, error) {
      debugPrint("Error Loading Image: $url");
      return showErrorWidget
          ? Image.asset(
              ImageAssets.person2,
              height: height,
              width: height,
              fit: BoxFit.fill,
            )
          : SizedBox();
    },
  );
}
