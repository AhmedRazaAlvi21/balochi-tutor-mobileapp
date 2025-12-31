import 'package:balochi_tutor/controllers/settings_controller/settings_controller.dart';
import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:balochi_tutor/screens/dashboard/home_page/notification_screen/notification_screen.dart';
import 'package:balochi_tutor/screens/dashboard/home_page/translation_page/translation_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller/profile_controller.dart';
import '../../../res/assets/AppNetworkImage.dart';
import '../../../res/assets/CacheImageWidget.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/custom_text.dart';
import '../widget/course_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final List<Map<String, String>> _items = [
    {
      "title": "Learn",
      "sub_title": "Balochi Language",
      "image": ImageAssets.preview2,
    },
    {
      "title": "Makrani or Sulemani?",
      "sub_title": "We got both",
      "image": ImageAssets.preview2,
    },
    {
      "title": "Start your 100 days",
      "sub_title": "challenge now",
      "image": ImageAssets.preview2,
    },
  ];

  final ProfileController profileController = Get.find<ProfileController>();
  final SettingsController settingsCont = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileController.dashboardData.value == null) {
        profileController.getDashboardData(context);
      }
      if (profileController.userProfileData.value == null) {
        profileController.getUserProfileData(context);
      }
    });
  }

  Future<void> _onRefresh() async {
    print("refresher ===========");
    await Future.wait([
      profileController.getDashboardData(
        context,
        forceRefresh: true,
      ),
      profileController.getUserProfileData(context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// ================= HEADER =================
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF896AE8), Color(0xFF9577F1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() {
                      final profileData = profileController.userProfileData.value;
                      final isLoading = profileController.isLoading.value;

                      // Show loading indicator when data is being fetched
                      if (isLoading && profileData == null) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Colors.white,
                              child: SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF896AE8)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomText(
                                title: "Loading...",
                                fontcolor: AppColor.whiteColor,
                                fontsize: 18.sp,
                                fontweight: FontWeight.w700,
                                maxline: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundColor: Colors.white,
                            child: (profileData?.userImg != null && profileData!.userImg!.isNotEmpty)
                                ? ClipOval(
                                    child: cacheImageWidget(
                                      profileData.userImg!,
                                      50.w,
                                      50.h,
                                      BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 50.sp,
                                    color: AppColor.greyColor,
                                  ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomText(
                              title: profileData?.name?.isNotEmpty == true ? profileData!.name! : "",
                              fontcolor: AppColor.whiteColor,
                              fontsize: 18.sp,
                              fontweight: FontWeight.w700,
                              maxline: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.subscriptionPlan);
                        },
                        child: AppAssetsImage(
                          imagePath: ImageAssets.premium,
                          height: 24.h,
                          width: 26.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                settingsCont.markAllAsSeen();
                                Get.to(() => NotificationScreen());
                              },
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 28.sp,
                              ),
                            ),
                            Obx(() {
                              return settingsCont.hasNewNotification
                                  ? Positioned(
                                      right: 5,
                                      top: 2,
                                      child: CircleAvatar(
                                        radius: 4,
                                        backgroundColor: AppColor.redColor,
                                      ),
                                    )
                                  : const SizedBox();
                            }),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const TranslationPage());
                        },
                        child: Icon(
                          size: 30.sp,
                          Icons.search,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// ================= BODY =================
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),

                    /// ================= CAROUSEL =================
                    Stack(
                      children: [
                        CarouselSlider(
                          items: _items
                              .map((item) => _carouselItem(
                                    item['title']!,
                                    item['sub_title']!,
                                    item['image']!,
                                  ))
                              .toList(),
                          carouselController: _controller,
                          options: CarouselOptions(
                            height: 160.h,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.95,
                            onPageChanged: (index, _) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _items.asMap().entries.map((entry) {
                              return Container(
                                width: _current == entry.key ? 12.w : 8.w,
                                height: 8.h,
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == entry.key ? AppColor.blueColor2 : AppColor.greyEBE,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    /// ================= UPDATES (ONLY THIS REBUILDS) =================
                    _updatesSection(),

                    /// ================= RECENTLY DONE =================
                    Obx(() {
                      final recently = profileController.dashboardData.value?.recentlyDone;

                      if (recently == null) return const SizedBox();

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recently Done",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            CourseCardWidget(
                              done: true,
                              title: "Day ${recently.dayNumber}",
                              subTitle: recently.title ?? "",
                              image: appNetworkImage(
                                recently.image,
                                100.w,
                                100.h,
                                BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carouselItem(String title, String subTitle, String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: double.infinity,
        color: AppColor.whiteColor,
        child: Stack(
          children: [
            Positioned(
              left: -100.w,
              bottom: 50,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: AppColor.primary3,
              ),
            ),
            Positioned(
              top: 80.w,
              right: -100,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: AppColor.primary3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.w, top: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: title,
                            fontsize: 26.sp,
                            fontweight: FontWeight.w700,
                          ),
                          SizedBox(height: 6.h),
                          CustomText(
                            title: subTitle,
                            fontsize: 18.sp,
                            fontweight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppAssetsImage(
                    imagePath: imagePath,
                    fit: BoxFit.scaleDown,
                    width: 146.w,
                    height: 146.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= UPDATES WIDGET =================
  Widget _updatesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.primary4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final controller = profileController;
        final updates = controller.dashboardData.value?.updates;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== HEADER =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Updates",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                /// 🔄 REFRESH ICON OR LOADER
                controller.isUpdatesLoading.value
                    ? SizedBox(
                        width: 22.w,
                        height: 22.h,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : InkWell(
                        onTap: () async {
                          await controller.getDashboardData(
                            context,
                            forceRefresh: true,
                            onlyUpdates: true, // ⭐ KEY
                          );
                        },
                        child: AppAssetsImage(
                          imagePath: ImageAssets.vector1,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
              ],
            ),

            SizedBox(height: 15.h),

            /// ===== CONTENT =====
            controller.isUpdatesLoading.value
                ? _updatesLoadingGrid()
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.h,
                    crossAxisSpacing: 5.w,
                    childAspectRatio: 2,
                    children: [
                      _updateCard(
                        ImageAssets.fireIcon,
                        "Day ${updates?.currentDay ?? ""}",
                        "30 mins daily",
                        false,
                      ),
                      _updateCard(
                        ImageAssets.calendarIcon,
                        "${updates?.lessonsPassed ?? ""}",
                        "Lessons Passed",
                        false,
                      ),
                      _updateCard(
                        ImageAssets.target,
                        "${updates?.correctPractices ?? ""}",
                        "Attempted Quiz",
                        false,
                      ),
                      _updateCard(
                        ImageAssets.xP,
                        "Quiz Passed",
                        "${updates?.quizPassed ?? ""}",
                        true,
                      ),
                    ],
                  ),
          ],
        );
      }),
    );
  }

  Widget _updatesLoadingGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 5.h,
      crossAxisSpacing: 5.w,
      childAspectRatio: 2,
      children: List.generate(
        4,
        (_) => Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _updateCard(String icon, String title, String subTitle, bool quiz) {
    return Card(
      color: AppColor.whiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: AppAssetsImage(
                imagePath: icon,
                fit: BoxFit.scaleDown,
                width: 24.w,
                height: 24.h,
              ),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: quiz ? 14.sp : 18.sp, fontWeight: FontWeight.w700, color: AppColor.black121)),
                    Text(subTitle,
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: AppColor.black161)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
