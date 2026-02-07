import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../controller/terms_condition_controller.dart';

class TermsConditionScreen extends StatelessWidget {
  TermsConditionScreen({super.key});

  final controller = Get.put(TermsConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.termsAndCondition.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final terms = controller.termsData.value;

          if (terms == null || terms.description == null) {
            return const Center(child: Text("No terms found"));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  AppStrings.termsAndCondition.tr,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(20)),

                /// Main Description (API Data)
                Text(
                  terms.description!,
                  style: AppTextStyles.body,
                ),

                SizedBox(height: Dimensions.h(100)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
