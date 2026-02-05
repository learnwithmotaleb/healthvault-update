import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../core/routes/route_path.dart';
import '../../profile/widget/profile_menu_item.dart';

class DocumentProfileScreen extends StatefulWidget {
  const DocumentProfileScreen({super.key});

  @override
  State<DocumentProfileScreen> createState() => _DocumentProfileScreenState();
}

class _DocumentProfileScreenState extends State<DocumentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.document.tr),
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
                  Get.toNamed(RoutePath.addDocument);
                },
              ),
              SizedBox(height: Dimensions.h(16),),
              ProfileMenuTile(
                icon: Icons.card_membership,
                title: AppStrings.familyMembers.tr,
                onTap: () {
                  Get.toNamed(RoutePath.familyDocument);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
