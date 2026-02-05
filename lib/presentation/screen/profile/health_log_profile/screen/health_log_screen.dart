import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../../profile/widget/profile_menu_item.dart';

class HealthLogScreen extends StatefulWidget {
  const HealthLogScreen({super.key});

  @override
  State<HealthLogScreen> createState() => _HealthLogScreenState();
}

class _HealthLogScreenState extends State<HealthLogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.healthLogs.tr),
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
                  Get.toNamed(RoutePath.healthLogMySelf);
                },
              ),
              SizedBox(height: Dimensions.h(16),),
              ProfileMenuTile(
                icon: Icons.card_membership,
                title: AppStrings.familyMembers.tr,
                onTap: () {
                  Get.toNamed(RoutePath.healthLogFamily);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
