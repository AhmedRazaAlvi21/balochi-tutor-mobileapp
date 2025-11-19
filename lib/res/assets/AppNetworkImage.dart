import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import 'image_assets.dart';

/// ---------
///  CLEAN URL HANDLER
/// ---------
String fixImageUrl(String? url) {
  if (url == null || url.trim().isEmpty || url == "null") {
    return ImageAssets.courseImage; // fallback asset
  }

  // If local asset (png/svg inside assets folder)
  if (url.startsWith("assets/")) return url;

  // Missing http? → add base URL automatically
  if (!url.startsWith("http")) {
    return "https://your-base-url.com/$url";
  }

  // Final clean valid URL
  return url;
}

/// ---------
///  MAIN IMAGE WIDGET
/// ---------
Widget appNetworkImage(String? originalUrl, double? width, double? height, BoxFit boxFit,
    {Color? imageColor,
    Color? svgColor,
    bool showLoadingShimmers = true,
    bool showLoading = true,
    bool showErrorWidget = true,
    Color? svgBackgroundColor,
    shimmerBackgroundColor,
    Alignment alignment = Alignment.center,
    BoxFit? svgBoxFit}) {
  /// use fixed/clean URL ALWAYS
  final url = fixImageUrl(originalUrl);

  // Local asset fallback
  if (!url.startsWith("http")) {
    return Image.asset(
      url,
      height: height,
      width: width,
      fit: boxFit,
    );
  }

  debugPrint("Final Image URL: $url");

  // Extension
  String ext = url.split('.').last.toLowerCase();

  /// --------- SVG HANDLING ----------
  if (ext == 'svg') {
    return Material(
      color: svgBackgroundColor ?? Colors.transparent,
      child: SvgPicture.network(
        url,
        fit: svgBoxFit ?? boxFit,
        width: width,
        height: height,
        color: svgColor,
        alignment: alignment,
        placeholderBuilder: (context) => showLoadingShimmers
            ? Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey,
                child: Container(
                  width: width,
                  height: height,
                  color: shimmerBackgroundColor ?? Colors.grey,
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  /// --------- NORMAL IMAGE (PNG/JPEG/WEBP) ----------
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: boxFit,
    alignment: alignment,
    color: imageColor,
    progressIndicatorBuilder: (context, url, progress) {
      return showLoading
          ? showLoadingShimmers
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey,
                  child: Container(
                    width: width,
                    height: height,
                    color: shimmerBackgroundColor ?? Colors.grey,
                  ),
                )
              : Center(child: CircularProgressIndicator())
          : SizedBox();
    },
    errorWidget: (context, url, error) {
      debugPrint("Image Load Failed: $url");
      return showErrorWidget
          ? Image.asset(
              ImageAssets.courseImage,
              height: height,
              width: width,
            )
          : SizedBox();
    },
  );
}
