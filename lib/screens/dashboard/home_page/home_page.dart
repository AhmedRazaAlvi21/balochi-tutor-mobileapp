import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:balochi_tutor/res/routes/routes_name.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller/profile_controller.dart';
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
      "title": "Learn Balochi Language.",
      "image": "assets/image1.png",
    },
    {
      "title": "Practice Daily to Improve",
      "image": "assets/image2.png",
    },
  ];
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final dashboardData = profileController.dashboardData.value;
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF896AE8), Color(0xFF9577F1)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundColor: Colors.white,
                            child: (dashboardData?.user?.userImg != null && dashboardData!.user!.userImg!.isNotEmpty)
                                ? ClipOval(
                                    child: Image.network(
                                      dashboardData.user!.userImg!,
                                      fit: BoxFit.cover,
                                      width: 50.w,
                                      height: 50.h,
                                      errorBuilder: (context, error, stackTrace) {
                                        // If image fails to load
                                        return Icon(
                                          Icons.person,
                                          size: 30.sp,
                                          color: AppColor.greyColor,
                                        );
                                      },
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 50.sp,
                                    color: AppColor.greyColor,
                                  ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dashboardData?.user?.name ?? "user 1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "User ID: 002323",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouteName.subscriptionPlan);
                            },
                            child: AppAssetsImage(
                              imagePath: ImageAssets.premium,
                              fit: BoxFit.scaleDown,
                              height: 24.h,
                              width: 26.w,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Icon(Icons.notifications, color: Colors.white, size: 28.sp),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              // --- Carousel Section ---
              Stack(
                children: [
                  CarouselSlider(
                    items: _items.map((item) => _carouselItem(item['title']!, item['image']!)).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: 160.h,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      enlargeCenterPage: true,
                      viewportFraction: 0.95,
                      onPageChanged: (index, reason) {
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
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: _current == entry.key ? 12.w : 8.w,
                            height: 8.h,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key ? Colors.black : Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              // --- Updates Section ---
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primary4,
                ),
                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Updates", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700)),
                        InkWell(
                          onTap: () async {
                            await profileController.getUserProfileData(context);
                            await profileController.getDashboardData(context);
                          },
                          child: AppAssetsImage(
                            imagePath: ImageAssets.vector1,
                            fit: BoxFit.scaleDown,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 5.h,
                      crossAxisSpacing: 5.w,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 2,
                      children: [
                        _updateCard(ImageAssets.fireIcon, "Day ${dashboardData?.updates?.currentDay ?? ""}",
                            "1.5 Hours Daily", false),
                        _updateCard(ImageAssets.calendarIcon, "${dashboardData?.updates?.lessonsPassed ?? ""}",
                            "Lessons Passed", false),
                        _updateCard(ImageAssets.target, "${dashboardData?.updates?.correctPractices ?? ""}",
                            "Correct Practices", false),
                        _updateCard(ImageAssets.xP, "Quiz Passed", "${dashboardData?.updates?.quizPassed ?? ""}", true),
                      ],
                    ),
                  ],
                ),
              ),

              // --- Recently Done Section ---
              if (dashboardData?.recentlyDone != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recently Done", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.h),
                      CourseCardWidget(
                        done: true,
                        title: dashboardData?.recentlyDone?.title ?? "No Title",
                        subTitle: dashboardData?.recentlyDone?.description ?? "",
                        lesson: "${dashboardData?.recentlyDone?.order ?? '0'} Lessons",
                        words: "${dashboardData?.recentlyDone?.order ?? '0'} Words",
                        image: dashboardData?.recentlyDone?.image,
                      ),
                    ],
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        );
      }),
    );
  }

  Widget _carouselItem(String title, String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
        ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 40.w, top: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: 'Learn',
                            fontsize: 20.sp,
                            fontcolor: AppColor.blackColor,
                            fontweight: FontWeight.w400,
                          ),
                          CustomText(
                            title: 'Balochi',
                            fontsize: 28.sp,
                            fontweight: FontWeight.w700,
                          ),
                          CustomText(
                            title: 'Language.',
                            fontsize: 20.sp,
                            fontcolor: AppColor.blackColor,
                            fontweight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppAssetsImage(
                    imagePath: ImageAssets.preview2,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAssetsImage(
              imagePath: icon,
              fit: BoxFit.scaleDown,
              width: 28.w,
              height: 28.h,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: quiz ? 14.sp : 18.sp, fontWeight: FontWeight.w700, color: AppColor.black121)),
                  Text(subTitle,
                      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: AppColor.black161)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
