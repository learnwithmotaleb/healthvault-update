import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';


import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/confermation_alert.dart';
import '../controller/account_setting_controller.dart';
import '../widget/account_setting_widget.dart';

class AccountSettingScreen extends StatelessWidget {
   AccountSettingScreen({super.key});

  final controller = Get.put(AccountSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.changePassword.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// Change Password
            AccountSettingMenuTile(
              width: double.infinity,
              height: Dimensions.h(56),
              icon: Icons.lock_outline,
              title: AppStrings.changePassword.tr,
              fontSize: 14,
              color: AppColors.whiteColor,
              iconColor: AppColors.primaryColor,
              textColor: AppColors.blackColor,
              onTap: () {
                Get.toNamed(RoutePath.changePassword);
              },
            ),

            SizedBox(height: Dimensions.h(12)),

            /// Delete Account
            AccountSettingMenuTile(
              width: double.infinity,
              height: Dimensions.h(56),
              icon: Icons.person_outline,
              title: AppStrings.deleteAccount.tr,
              fontSize: 14,
              color: AppColors.whiteColor,
              iconColor: AppColors.emergencyColor,
              textColor: AppColors.emergencyColor,
              onTap: () {
                CustomAlertDialog.show(
                  context: context,
                  title: AppStrings.deleteAccount.tr,
                  body: AppStrings.areYouSureYouWantToDelete.tr,
                  onYes: () {
                    Get.back(); // close dialog
                    controller.deleteAccount(); // call API

                  },
                  onNo: () {
                    Get.back();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
