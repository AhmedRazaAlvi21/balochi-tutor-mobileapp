import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import 'image_assets.dart';

Widget appNetworkImage(String? url, double? width, double? height, BoxFit boxFit,
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
      ImageAssets.noImages,
      height: height,
      width: width,
      fit: boxFit,
    );
  }

  // Debugging: Print URL to check if it's valid
  debugPrint("Loading Image URL: $url");

  String fileExtension = url.split('.').last.toLowerCase(); // Get file extension properly

  if (fileExtension == 'svg') {
    return Material(
      color: svgBackgroundColor ?? Colors.transparent,
      child: SvgPicture.network(url,
          fit: svgBoxFit ?? boxFit,
          width: width,
          alignment: alignment,
          color: svgColor,
          height: height,
          placeholderBuilder: (BuildContext context) => showLoadingShimmers
              ? Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey,
                  child: Container(
                    alignment: Alignment.center,
                    color: shimmerBackgroundColor ?? Colors.grey,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: Text("Loading..."),
                  ),
                )
              : Center(child: CircularProgressIndicator())),
    );
  } else {
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
        debugPrint("Error Loading Image: $url"); // Debugging if image fails to load
        return showErrorWidget
            ? Image.asset(
                ImageAssets.noImages,
                height: height,
                width: width,
              )
            : SizedBox();
      },
    );
  }
}
