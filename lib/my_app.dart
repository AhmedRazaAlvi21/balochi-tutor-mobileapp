import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/getx_localization/languages.dart';
import 'package:balochi_tutor/res/routes/routes.dart';
import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'app_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SkeletonizerConfig(
          data: SkeletonizerConfigData(
            effect: const ShimmerEffect(),
            justifyMultiLineText: true,
            textBorderRadius: TextBoneBorderRadius.fromHeightFactor(.5),
            ignoreContainers: false,
          ),
          child: GetMaterialApp(
            title: 'Balochi Tutor',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColor.primaryColor,
                surfaceTint: Colors.transparent,
              ),
              primaryColor: AppColor.primaryColor,
              textTheme: GoogleFonts.nunitoTextTheme(
                Theme.of(context).textTheme,
              ),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: AppColor.blackColor,
                ),
              ),
              scaffoldBackgroundColor: Colors.transparent,
            ),
            translations: Languages(),
            locale: const Locale('en', 'US'),
            fallbackLocale: const Locale('en', 'US'),
            initialRoute: RouteName.splashScreen,
            getPages: AppRoutes.appRoutes(),
            unknownRoute: RouteName.unknownRoute,
            initialBinding: AppBindings(),
          ),
        );
      },
    );
  }
}
