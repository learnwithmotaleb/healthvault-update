import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../controller/privacy_policy_controller.dart';
import '../widget/privacy_item_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.privacyPolicy.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final policy = controller.policyData.value;

          if (policy == null) {
            return const Center(child: Text("No privacy policy found"));
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  AppStrings.privacyPolicy.tr,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                /// Description
                Text(
                  policy.description ?? '',
                  style: AppTextStyles.body,
                ),

                SizedBox(height: Dimensions.h(24)),


              ],
            ),
          );
        }),
      ),
    );
  }
}
