import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../colors/app_color.dart';
import 'background_widget.dart';
import 'custom_text.dart';

class LoadingPage extends StatelessWidget {
  final String? title;

  const LoadingPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BackgroundWidget(
        child: Scaffold(
          // backgroundColor: AppColor.whiteColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Circular progress indicator.
                SpinKitCircle(
                  size: 55.0,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor,
                      ),
                    );
                  },
                ),
                // Text that says "Loading..."
                CustomText(
                  title: title ?? 'Loading...',
                  fontcolor: AppColor.blackColor,
                  textalign: TextAlign.center,
                  fontsize: 24,
                  fontweight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
