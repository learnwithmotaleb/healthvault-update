import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/helper/local_db/local_db.dart';
import 'package:healthvault/service/api_url.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/confermation_alert.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../profile/profile/widget/infor_row_profile_widget.dart';
import '../../../profile/profile/widget/profile_menu_item.dart';
import '../controller/provider_profile_controller.dart';

class ProviderProfileScreen extends StatefulWidget {
  const ProviderProfileScreen({super.key});

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  final controller = Get.put(ProviderProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.profile.tr,
        showBack: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              /// ===== PROFILE CARD =====
              /// ===== PROFILE CARD =====
              Obx(() {
                final profile = controller.profile.value;

                // Show loading if data is being fetched
                if (controller.isLoading.value) {
                  return Container(
                    width: double.infinity,
                    height: Dimensions.h(190),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }

                // Show empty state if no data
                if (profile?.data == null) {
                  return Container(
                    width: double.infinity,
                    height: Dimensions.h(190),
                    alignment: Alignment.center,
                    child: const Text("No profile data found"),
                  );
                }

                final data = profile!.data!;
                final provider = data.provider;

                return Container(
                  width: double.infinity,
                  height: Dimensions.h(190),
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: (provider?.profileImage ?? "").isNotEmpty
                                  ? Image.network(
                                "${ApiUrl.mainDomain}/${provider!.profileImage!.replaceAll("\\", "/")}", // fix backslash
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: AppColors.greyColor.withOpacity(0.2),
                                    child: const Center(
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  AppImages.motalebImage,
                                  width: 80,
                                  height: 80,
                                ),
                              )
                                  : Image.asset(
                                AppImages.motalebImage,
                                width: 80,
                                height: 80,
                              ),

                            ),
                            SizedBox(width: Dimensions.w(12)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.fullName ?? "",
                                  style: AppTextStyles.title,
                                ),
                                SizedBox(height: Dimensions.h(8)),
                                InfoRowProfile(
                                  icon: Icons.phone,
                                  text: data.phone ?? "",
                                ),
                                SizedBox(height: Dimensions.h(6)),
                                InfoRowProfile(
                                  icon: Icons.alternate_email,
                                  text: data.email ?? "",
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: Dimensions.h(12)),

                        /// ===== EDIT BUTTON =====
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutePath.editProfile);
                            },
                            child: Container(
                              width: Dimensions.w(100),
                              height: Dimensions.w(40),
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
                );
              }),


              SizedBox(height: Dimensions.h(16)),

              /// ===== MENU ITEMS =====
              ProfileMenuTile(
                icon: Icons.settings,
                title: AppStrings.accountSetting.tr,
                onTap: () => Get.toNamed(RoutePath.accountSetting),
              ),
              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.calendar_month,
                title: AppStrings.editSchedule.tr,
                onTap: () => Get.toNamed(RoutePath.providerSchedule),
              ),
              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.home_repair_service,
                title: AppStrings.addService.tr,
                onTap: () => Get.toNamed(RoutePath.providerService),
              ),
              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.question_mark_rounded,
                title: AppStrings.faq.tr,
                onTap: () => Get.toNamed(RoutePath.faq),
              ),
              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.language,
                title: AppStrings.language.tr,
                onTap: () => Get.toNamed(RoutePath.changeLanguageProfile),
              ),
              ProfileMenuTile(
                icon: Icons.notifications,
                title: AppStrings.notification.tr,
                onTap: () => Get.toNamed(RoutePath.notification),
              ),
              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.library_books_sharp,
                title: AppStrings.termsAndCondition.tr,
                onTap: () => Get.toNamed(RoutePath.termsAndCondition),
              ),
              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.privacy_tip_outlined,
                title: AppStrings.privacyPolicy.tr,
                onTap: () => Get.toNamed(RoutePath.policy),
              ),
              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.logout_rounded,
                title: AppStrings.logOut.tr,
                onTap: () {
                  CustomAlertDialog.show(
                    context: context,
                    title: AppStrings.logOut.tr,
                    body: AppStrings.areYouSureWantToLogOut.tr,
                    onYes: (){
                      SharePrefsHelper.clearAll().then((value){
                        AppSnackBar.success(title: "Health Vault","Logout Successful");
                        Get.offAllNamed(RoutePath.login);

                      });

                    },
                    onNo: () => Get.back(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
