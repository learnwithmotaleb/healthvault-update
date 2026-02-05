import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
<<<<<<< Updated upstream
import 'package:healthvault/helper/local_db/local_db.dart';
import 'package:healthvault/service/api_url.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
=======
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../global/language/controller/language_controller.dart';
>>>>>>> Stashed changes
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../widget/confermation_alert.dart';
import '../../../../widget/open_url.dart';
import '../../../profile/profile/widget/infor_row_profile_widget.dart';
import '../../../profile/profile/widget/profile_menu_item.dart';
import '../../../profile/profile/widget/profile_section_title.dart';

class ProviderProfileScreen extends StatefulWidget {
  const ProviderProfileScreen({super.key});

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final lc = LanguageController.to;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.profile.tr,showBack: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              Container(
                  width: double.infinity,
                  height: Dimensions.h(190),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),

                      color: AppColors.whiteColor,
                      boxShadow:[
                        BoxShadow(
                            color: AppColors.greyColor.withOpacity(0.2),
                            blurRadius:1,
                            offset: Offset(0,1),
                            spreadRadius: 0.5
                        )
                      ]
                  ),
                  child: Padding(
                    padding:EdgeInsets.all(10),
                    child:SingleChildScrollView(
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment:  MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(AppImages.motalebImage,width: 80, height: 80,)),
                              SizedBox(width: Dimensions.w(30)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Abdul Motaleb",style: AppTextStyles.title),
                                  SizedBox(height: Dimensions.h(8)),
                                  InfoRowProfile(
                                    icon: Icons.phone,
                                    text: "(555) 123-4567",
                                  ),

                                  SizedBox(height: Dimensions.h(6)),
                                  InfoRowProfile(
                                    icon: Icons.alternate_email,
                                    text: "example@gmail.com",
                                  ),


                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.h(12)),

                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutePath.editProfile);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Container(
                                  width: Dimensions.w(100),
                                  height: Dimensions.w(40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColors.primaryColor,

                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.editProfile.tr,
                                        style: AppTextStyles.body.copyWith(
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: Dimensions.h(16)),

              ProfileMenuTile(
                icon: Icons.settings,
                title: AppStrings.accountSetting.tr,
                onTap: () {
                  Get.toNamed(RoutePath.accountSetting);
                },
              ),

              SizedBox(height: Dimensions.h(10)),

              ProfileMenuTile(
                icon: Icons.calendar_month,
                title: AppStrings.editSchedule.tr,
                onTap: () {
                  Get.toNamed(RoutePath.providerSchedule);
                },
              ),

              SizedBox(height: Dimensions.h(10)),

              ProfileMenuTile(
                icon: Icons.home_repair_service,
                title: AppStrings.addService.tr,
                onTap: () {
                  Get.toNamed(RoutePath.providerService);

                },
              ),

              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.question_mark_rounded,
                title: AppStrings.faq.tr,
                onTap: () {
                  Get.toNamed(RoutePath.faq);
                },
              ),

              SizedBox(height: Dimensions.h(10)),



              ProfileMenuTile(
                icon: Icons.language,
                title: AppStrings.language.tr,
                onTap: () {
                  Get.toNamed(RoutePath.changeLanguageProfile);
                },
              ),
              ProfileMenuTile(
                icon: Icons.notifications,
                title: AppStrings.notification.tr,
                onTap: () {

                  Get.toNamed(RoutePath.notification);


                },
              ),


              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.library_books_sharp,
                title: AppStrings.termsAndCondition.tr,
                onTap: () {
                  Get.toNamed(RoutePath.termsAndCondition);
                },
              ),



              SizedBox(height: Dimensions.h(10)),

              ProfileMenuTile(
                icon: Icons.privacy_tip_outlined,
                title: AppStrings.privacyPolicy.tr,
                onTap: () {
                  Get.toNamed(RoutePath.policy);
                },
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
                    onYes: () {
                      Get.toNamed(RoutePath.login);

                    },
                    onNo: () {
                      Get.back();
                    },
                  );


                },
              ),
            ],

<<<<<<< Updated upstream
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
=======
>>>>>>> Stashed changes
          ),
        ),
      ),
    );
  }
}
