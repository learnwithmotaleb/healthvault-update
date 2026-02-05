import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../profile/widget/profile_menu_item.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.insurance.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,
              vertical: 10),
          child: Column(
            children: [
              ProfileMenuTile(
                icon: Icons.person,
                title: AppStrings.mySelf.tr,
                onTap: () {
                  Get.toNamed(RoutePath.insuranceMySelf);
                },
              ),
              SizedBox(height: Dimensions.h(16),),
              ProfileMenuTile(
                icon: Icons.card_membership,
                title: AppStrings.familyMembers.tr,
                onTap: () {
                  Get.toNamed(RoutePath.insuranceFamily);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
