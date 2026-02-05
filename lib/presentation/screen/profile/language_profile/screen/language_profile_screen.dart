import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../controller/language_profile_controller.dart';


class LanguageProfileScreen extends StatelessWidget {
  LanguageProfileScreen({super.key});

  // Initialize the LanguageSettingController
  final LanguageProfileController lsc =
  Get.put(LanguageProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.language.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(10)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
          
              /// Language title
              Text(
                AppStrings.language.tr,
                style: TextStyle(
                  fontSize: Dimensions.h(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Dimensions.h(16)),
          
              /// English
              _languageItem(
                flag: AppImages.englishImage,
                title: AppStrings.english,
                value: 'en',
              ),
              SizedBox(height: Dimensions.h(12)),
          
              /// Arabic
              _languageItem(
                flag: AppImages.greekImage,
                title: AppStrings.greek,
                value: 'el',
              ),


              SizedBox(height: Dimensions.h(150)),



              /// Submit button (optional, can remove if instant update)
              HVButton(
                label: AppStrings.continueButton.tr,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageItem({
    required String flag,
    required String title,
    required String value,
  }) {
    return Obx(() => GestureDetector(
      onTap: () => lsc.changeLanguage(value),
      child: Center(
        child: Container(
          width: Dimensions.w(356),
          height: Dimensions.h(50),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(8),
            vertical: Dimensions.h(8),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: lsc.selectedLanguage.value == value
                  ? AppColors.primaryColor
                  : AppColors.primaryColor,
            ),
          ),
          child: Row(
            children: [
              /// Flag
              CircleAvatar(
                radius: Dimensions.r(28),
                backgroundImage: AssetImage(flag),
              ),
              SizedBox(width: Dimensions.w(15)),

              /// Text
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),

              /// Select icon
              Icon(
                lsc.selectedLanguage.value == value
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                size: 20,
                color: lsc.selectedLanguage.value == value
                    ? AppColors.primaryColor
                    : AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
