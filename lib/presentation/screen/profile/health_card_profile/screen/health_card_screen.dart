import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

class HealthCardScreen extends StatefulWidget {
  const HealthCardScreen({super.key});

  @override
  State<HealthCardScreen> createState() => _HealthCardScreenState();
}

class _HealthCardScreenState extends State<HealthCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.healthCardID.tr),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: AppColors.primaryColor)
              ),
              child: Center(
                child: Text("Coming Card!",style: AppTextStyles.body,),
              ),
            ),
          )

        ],
      ),
    );
  }
}
