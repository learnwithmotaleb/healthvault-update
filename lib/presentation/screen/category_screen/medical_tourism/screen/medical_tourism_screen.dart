import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';

class MedicalTourismScreen extends StatefulWidget {
  const MedicalTourismScreen({super.key});

  @override
  State<MedicalTourismScreen> createState() => _MedicalTourismScreenState();
}

class _MedicalTourismScreenState extends State<MedicalTourismScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title:AppStrings.medicalTourism.tr),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppImages.comingSoonImage, fit: BoxFit.cover,))
        ],
      ),
    );
  }
}
