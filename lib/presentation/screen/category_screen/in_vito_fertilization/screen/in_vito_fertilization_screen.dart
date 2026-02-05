import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';

class InVitoFertilizationScreen extends StatefulWidget {
  const InVitoFertilizationScreen({super.key});

  @override
  State<InVitoFertilizationScreen> createState() => _InVitoFertilizationScreenState();
}

class _InVitoFertilizationScreenState extends State<InVitoFertilizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.inVitoFertilization.tr),

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
