import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';


class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.termsAndCondition.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                AppStrings.termsAndCondition,
                style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.normal,
                  color: AppColors.blackColor
                ),
              ),

              SizedBox(height: Dimensions.h(20)),

              /// Subtitle
              Text(
                "The Quick Brown the fox jumps over the lazy dog, The Quick Brown the fox jumps over ther lazy dog, the quick brown the fox jumpber the lazy dog. ",
                style: AppTextStyles.body,

              ),

              SizedBox(height: Dimensions.h(32)),

              /// Terms List
              const _TermsItem(
                index: "1",
                text:
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              ),
              const _TermsItem(
                index: "2",
                text:
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              ),
              const _TermsItem(
                index: "3",
                text:
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              ),
              const _TermsItem(
                index: "4",
                text:
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              ),
              const _TermsItem(
                index: "5",
                text:
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              ),
              const _TermsItem(
                index: "6",
                text:
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              ),

              SizedBox(height: Dimensions.h(100)),
            ],
          ),
        ),
      ),
    );
  }
}

/// --------------------------------------------
/// Reusable Terms Item Widget
/// --------------------------------------------
class _TermsItem extends StatelessWidget {
  final String index;
  final String text;

  const _TermsItem({
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(24)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimensions.w(24),
            child: Text(
              index,
              style: AppTextStyles.body,

            ),
          ),
          SizedBox(width: Dimensions.w(8)),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body,

            ),
          ),
        ],
      ),
    );
  }
}
