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
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/confermation_alert.dart';
import '../../../../widget/custom_alert.dart';
import '../../../../widget/open_url.dart';
import '../controller/profile_controller.dart';
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
                height: Dimensions.h(180),
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

                        Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          final user = controller.userData.value;
                          final baseUrl = "${ApiUrl.mainDomain}/"; // your server URL

                          // Get the profile image path
                          final profileImage = (user?.normalUserDetails?.isNotEmpty ?? false)
                              ? user!.normalUserDetails![0].profileImage
                              : null;

                          // Full URL
                          final fullImageUrl = (profileImage != null && profileImage.isNotEmpty)
                              ? "$baseUrl${profileImage.replaceAll("\\", "/")}"
                              : null;

                          // Get the first letter of the user's full name
                          final firstLetter = (user?.fullName != null && user!.fullName!.isNotEmpty)
                              ? user.fullName![0].toUpperCase()
                              : "?";

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.primaryColor,
                                  backgroundImage: fullImageUrl != null
                                      ? NetworkImage(fullImageUrl) // ✅ use NetworkImage here
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
                              ),
                              SizedBox(width: Dimensions.w(30)),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.fullName ?? "Loading...",
                                    style: AppTextStyles.title,
                                  ),
                                  SizedBox(height: Dimensions.h(8)),
                                  InfoRowProfile(
                                    icon: Icons.phone,
                                    text: user?.phone ?? "No phone",
                                  ),
                                  SizedBox(height: Dimensions.h(6)),
                                  InfoRowProfile(
                                    icon: Icons.alternate_email,
                                    text: user?.email ?? "No email",
                                  ),
                                ],
                              )
                            ],
                          );
                        }),


                        // Row(
                        //   mainAxisAlignment:  MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     ClipRRect(
                        //         borderRadius: BorderRadius.circular(20),
                        //         child: Image.asset(AppImages.motalebImage,width: 80, height: 80,)),
                        //     SizedBox(width: Dimensions.w(30)),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text("Abdul Motaleb",style: AppTextStyles.title),
                        //         SizedBox(height: Dimensions.h(8)),
                        //         InfoRowProfile(
                        //           icon: Icons.phone,
                        //           text: "(555) 123-4567",
                        //         ),
                        //
                        //         SizedBox(height: Dimensions.h(6)),
                        //         InfoRowProfile(
                        //           icon: Icons.alternate_email,
                        //           text: "example@gmail.com",
                        //         ),
                        //
                        //
                        //       ],
                        //     ),
                        //   ],
                        // ),
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
              SizedBox(height: Dimensions.h(30)),

              ProfileMenuTile(
                icon: Icons.settings,
                title: AppStrings.accountSetting.tr,
                onTap: () {
                  Get.toNamed(RoutePath.accountSetting);
                },
              ),

              SizedBox(height: Dimensions.h(10)),

              ProfileMenuTile(
                icon: Icons.library_books_sharp,
                title: AppStrings.document.tr,
                onTap: () {
                  Get.toNamed(RoutePath.document);
                },
              ),

              SizedBox(height: Dimensions.h(10)),

              ProfileMenuTile(
                icon: Icons.fact_check_rounded,
                title: AppStrings.insurance.tr,
                onTap: () {
                  Get.toNamed(RoutePath.insurance);

                },
              ),

              SizedBox(height: Dimensions.h(10)),

              ProfileMenuTile(
                icon: Icons.heart_broken_sharp,
                title: AppStrings.healthLogs.tr,
                onTap: () {
                  Get.toNamed(RoutePath.healthLog);
                },
              ),

              SizedBox(height: Dimensions.h(10)),
              ProfileMenuTile(
                icon: Icons.notifications,
                title: AppStrings.notification.tr,
                onTap: () {

                  Get.toNamed(RoutePath.notification);


                },
              ),
              SizedBox(height: Dimensions.h(10)),


              ProfileMenuTile(
                icon: Icons.health_and_safety_rounded,
                title: AppStrings.myHealth.tr,
                onTap: () {
                  openExternalUrl("https://citizen.ehealthrecord.gov.gr/auth/signin");
                },
              ),
              SizedBox(height: Dimensions.h(10)),


              ProfileMenuTile(
                icon: Icons.favorite,
                title: AppStrings.favourite.tr,
                onTap: () {
                  Get.toNamed(RoutePath.favourite);
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





              SizedBox(height: Dimensions.h(10)),


              ProfileMenuTile(
                icon: Icons.credit_card,
                title: AppStrings.healthCardID.tr,
                onTap: () {
                  Get.toNamed(RoutePath.healthCard);
                },
              ),



              SizedBox(height: Dimensions.h(10)),

              ProfileSectionTitle(title: AppStrings.more),

              SizedBox(height: Dimensions.h(20)),
              ProfileMenuTile(
                icon: Icons.library_books_sharp,
                title: AppStrings.termsAndCondition.tr,
                onTap: () {
                  Get.toNamed(RoutePath.termsAndCondition);
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
                icon: Icons.privacy_tip_outlined,
                title: AppStrings.privacyPolicy.tr,
                onTap: () {
                  Get.toNamed(RoutePath.policy);
                },
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
                      SharePrefsHelper.clearAll().then((value){
                        AppSnackBar.success("Logout Successfully");
                        Get.toNamed(RoutePath.login);
                      });


                    },
                    onNo: () {
                      Get.back();
                    },
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
