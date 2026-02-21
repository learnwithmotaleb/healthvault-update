import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/helper/local_db/local_db.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/service/api_url.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../global/language/controller/language_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/confermation_alert.dart';
import '../../../../widget/custom_alert.dart';
import '../../../../widget/open_url.dart';
import '../controller/profile_controller.dart';
import '../simmer_effect/simmer_effect.dart';
import '../widget/infor_row_profile_widget.dart';
import '../widget/profile_menu_item.dart';
import '../widget/profile_section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.profile.tr, showBack: false),
      body: Obx(() {
        // ── Loading state → full page shimmer ──
        if (controller.isLoading.value) {
          return const ProfileScreenShimmer();
        }

        final profile = controller.profileData.value;

        // ✅ Use ApiUrl.buildImageUrl() helper
        final rawImage = profile?.profileImage ?? "";
        final fullImageUrl = rawImage.isNotEmpty
            ? ApiUrl.buildImageUrl(rawImage)
            : null;

        // ✅ Fallback avatar first letter
        final firstLetter = (profile?.fullName != null && profile!.fullName!.isNotEmpty)
            ? profile.fullName![0].toUpperCase()
            : "?";

        return RefreshIndicator(
          onRefresh: () => controller.refreshProfile(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // ── Profile header card ──
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.2),
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✅ Profile avatar
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: AppColors.primaryColor,
                                backgroundImage: fullImageUrl != null
                                    ? NetworkImage(fullImageUrl)
                                    : null,
                                child: fullImageUrl == null
                                    ? Text(
                                  firstLetter,
                                  style: AppTextStyles.title.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 30,
                                  ),
                                )
                                    : null,
                              ),
                              SizedBox(width: Dimensions.w(16)),

                              // ✅ Name + role-based info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile?.fullName ?? "",
                                      style: AppTextStyles.title,
                                    ),
                                    SizedBox(height: Dimensions.h(4)),

                                    // ✅ Role badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        controller.role,
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h(6)),

                                    // ✅ Provider only
                                    if (controller.isProvider) ...[
                                      InfoRowProfile(
                                        icon: Icons.medical_services,
                                        text: profile?.specialization ??
                                            "No specialization",
                                      ),
                                      SizedBox(height: Dimensions.h(4)),
                                      InfoRowProfile(
                                        icon: Icons.verified_user,
                                        text: profile
                                            ?.providerTypeId?.label ??
                                            "",
                                      ),
                                      SizedBox(height: Dimensions.h(4)),
                                      InfoRowProfile(
                                        icon: Icons.work_history,
                                        text:
                                        "${profile?.yearsOfExperience ?? 0} yrs experience",
                                      ),
                                    ],

                                    // ✅ User only
                                    if (controller.isNormalUser) ...[
                                      InfoRowProfile(
                                        icon: Icons.bloodtype,
                                        text: profile?.bloodGroup ??
                                            "No blood group",
                                      ),
                                      SizedBox(height: Dimensions.h(4)),
                                      if (profile?.membershipId != null)
                                        InfoRowProfile(
                                          icon: Icons.card_membership,
                                          text:
                                          "Member: ${profile?.membershipId}",
                                        ),
                                      SizedBox(height: Dimensions.h(4)),
                                      if (profile?.gender != null)
                                        InfoRowProfile(
                                          icon: Icons.person,
                                          text: profile?.gender ?? "",
                                        ),
                                    ],

                                    SizedBox(height: Dimensions.h(4)),
                                    // ✅ Both
                                    InfoRowProfile(
                                      icon: Icons.location_on,
                                      text:
                                      profile?.address ?? "No address",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.h(12)),

                          // ✅ Edit profile button
                          GestureDetector(
                            onTap: () => Get.toNamed(RoutePath.editProfile),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: Dimensions.w(100),
                                height: Dimensions.w(36),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColors.primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    AppStrings.editProfile.tr,
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(30)),

                  // ── Menu items ──
                  ProfileMenuTile(
                    icon: Icons.settings,
                    title: AppStrings.accountSetting.tr,
                    onTap: () => Get.toNamed(RoutePath.accountSetting),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.library_books_sharp,
                    title: AppStrings.document.tr,
                    onTap: () => Get.toNamed(RoutePath.addDocument),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.fact_check_rounded,
                    title: AppStrings.insurance.tr,
                    onTap: () => Get.toNamed(RoutePath.insurance),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.heart_broken_sharp,
                    title: AppStrings.healthLogs.tr,
                    onTap: () => Get.toNamed(RoutePath.healthLog),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.notifications,
                    title: AppStrings.notification.tr,
                    onTap: () => Get.toNamed(RoutePath.notification),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.health_and_safety_rounded,
                    title: AppStrings.myHealth.tr,
                    onTap: () => openExternalUrl(
                        "https://citizen.ehealthrecord.gov.gr/auth/signin"),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.favorite,
                    title: AppStrings.favourite.tr,
                    onTap: () => Get.toNamed(RoutePath.favourite),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.language,
                    title: AppStrings.language.tr,
                    onTap: () =>
                        Get.toNamed(RoutePath.changeLanguageProfile),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.credit_card,
                    title: AppStrings.healthCardID.tr,
                    onTap: () => Get.toNamed(RoutePath.healthCard),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileSectionTitle(title: AppStrings.more),
                  SizedBox(height: Dimensions.h(20)),

                  ProfileMenuTile(
                    icon: Icons.library_books_sharp,
                    title: AppStrings.termsAndCondition.tr,
                    onTap: () => Get.toNamed(RoutePath.termsAndCondition),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.question_mark_rounded,
                    title: AppStrings.faq.tr,
                    onTap: () => Get.toNamed(RoutePath.faq),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.privacy_tip_outlined,
                    title: AppStrings.privacyPolicy.tr,
                    onTap: () => Get.toNamed(RoutePath.policy),
                  ),
                  SizedBox(height: Dimensions.h(10)),

                  ProfileMenuTile(
                    icon: Icons.logout,
                    title: AppStrings.logOut.tr,
                    onTap: () {
                      CustomAlertDialog.show(
                        context: context,
                        title: AppStrings.logOut.tr,
                        body: AppStrings.areYouSureWantToLogOut.tr,
                        onYes: () {
                          SharePrefsHelper.clearAll().then((_) {
                            AppSnackBar.success("Logout Successfully");
                            Get.toNamed(RoutePath.login);
                          });
                        },
                        onNo: () => Get.back(),
                      );
                    },
                  ),

                  SizedBox(height: Dimensions.h(30)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}