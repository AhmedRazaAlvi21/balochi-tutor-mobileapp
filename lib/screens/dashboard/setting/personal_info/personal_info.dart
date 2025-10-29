import 'package:balochi_tutor/res/extensions.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_controller/profile_controller.dart';
import '../../../../res/assets/CacheImageWidget.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/components/CustomprofileImagePickerWidget/CustomProfileImagePickerWidget.dart';
import '../../../../res/components/ProfileDialogBox/ProfileDialogBox.dart';
import '../../../../res/components/background_widget.dart';
import '../../../../res/components/custom_rounded_button.dart';
import '../../../../res/components/custom_text.dart';
import '../../../widget/custom_field_widget.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    if (!profileController.isDataFetched.value) {
      profileController.getUserProfileData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: CustomText(
            title: 'Personal Info',
            fontcolor: AppColor.blackColor,
            textalign: TextAlign.center,
            fontsize: 20,
            fontweight: FontWeight.w700,
          ),
        ),
        body: Obx(() {
          if (profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileController.errorMessage.isNotEmpty) {
            return Center(child: Text(profileController.errorMessage.value));
          }

          return RefreshIndicator(
            onRefresh: () async {
              profileController.isDataFetched.value = false;
              await profileController.getUserProfileData(context);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: context.blockSizeHorizontal * 25,
                            height: context.blockSizeHorizontal * 25,
                            child: Align(
                              alignment: Alignment.center,
                              child: Obx(() {
                                if (profileController.userImg.value != null) {
                                  return ClipOval(
                                    child: Image.file(profileController.userImg.value!,
                                        width: 120, height: 120, fit: BoxFit.cover),
                                  );
                                } else if (profileController.userProfileData.value?.userImg != null &&
                                    profileController.userProfileData.value!.userImg!.isNotEmpty) {
                                  return ClipOval(
                                    child: cacheImageWidget(
                                        profileController.userProfileData.value?.userImg ?? "", 120, 120, BoxFit.cover),
                                  );
                                } else {
                                  return CircleAvatar(
                                    radius: 45.0,
                                    backgroundColor: AppColor.whiteColor1,
                                    child: Icon(
                                      Icons.person,
                                      size: 60.0,
                                      color: AppColor.greyColor,
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: CustomProfileImagePickerWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomFieldWidget(
                    title: 'Full Name',
                    textcontroller: profileController.nameController,
                    defaultval: (profileController.userProfileData.value?.name?.isEmpty ?? true)
                        ? 'Andrew Ainsley'
                        : profileController.userProfileData.value?.name,
                  ),
                  CustomFieldWidget(
                    keyboardType: TextInputType.phone,
                    title: 'Phone Number'.tr,
                    textcontroller: profileController.phoneNumberController,
                    defaultval: (profileController.userProfileData.value?.phoneNo?.isEmpty ?? true)
                        ? "+923035550399"
                        : profileController.userProfileData.value?.phoneNo,
                  ),
                  CustomFieldWidget(
                    readonly: true,
                    title: 'Email'.tr,
                    textcontroller: profileController.emailController,
                    defaultval: (profileController.userProfileData.value?.email?.isEmpty ?? true)
                        ? "andrew.ainsley@yourdomain.com"
                        : profileController.userProfileData.value?.email,
                  ),
                  CustomFieldWidget(
                    title: 'Date of Birth'.tr,
                    readonly: true,
                    textcontroller: profileController.DOBController,
                    defaultval: (profileController.userProfileData.value?.dob?.isEmpty ?? true)
                        ? "2000-09-09"
                        : profileController.userProfileData.value?.dob,
                    suffixIcon: InkWell(
                      onTap: () => profileController.selectDate(context),
                      child: Icon(
                        Icons.calendar_month,
                        color: AppColor.primaryColor,
                        size: 30.0,
                      ),
                    ),
                  ),
                  CustomFieldWidget(
                    title: 'Country'.tr,
                    readonly: true,
                    textcontroller: profileController.CountryController,
                    defaultval: profileController.CountryController.text.isEmpty
                        ? "United States"
                        : profileController.CountryController.text,
                    suffixIcon: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            profileController.CountryController.text = country.name;
                            profileController.update();
                          },
                        );
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.primaryColor,
                        size: 35.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Obx(() {
                        return CustomRoundButton(
                          title: profileController.isLoading.value ? '' : 'update_profile'.tr,
                          isLoading: profileController.isLoading.value,
                          onPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ProfileDialogBox(
                                  continueButton: 'Update'.tr,
                                  onTap: () async {
                                    Get.back();
                                    profileController.isLoading.value = true;

                                    try {
                                      profileController.userProfileData.value?.userImg =
                                          profileController.userImg.string;
                                      await profileController.userProfileUpdate(context);
                                    } finally {
                                      profileController.isLoading.value = false;
                                    }
                                  },
                                  text: "Are you sure you want to update the profile?",
                                );
                              },
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
