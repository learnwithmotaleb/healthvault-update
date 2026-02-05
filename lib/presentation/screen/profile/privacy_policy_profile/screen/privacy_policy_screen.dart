import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../widget/privacy_item_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.privacyPolicy.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      AppStrings.privacyPolicy.tr,
                      style: AppTextStyles.title.copyWith(
                        fontWeight: FontWeight.normal
                      ),

                    ),

                    SizedBox(height: Dimensions.h(12)),

                    Text(
                      "The Quick brown the fox jumps over the lazy dog, the quick brown the fox jumps over the lazy dog, I love bangladesh, My mother land is Bangladesh.",
                      style: AppTextStyles.body,

                    ),



                    SizedBox(height: Dimensions.h(24)),

                    /// Privacy Policy List
                    ListView.separated(
                      itemCount: 6,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) =>
                          SizedBox(height: Dimensions.h(12)),
                      itemBuilder: (context, index) {
                        return PrivacyItemWidget(
                          index: '${index + 1}',
                          text:
                          'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                        );
                      },
                    ),

                    SizedBox(height: Dimensions.h(20)),
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
