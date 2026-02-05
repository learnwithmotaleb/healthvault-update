import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../health_log_family/controller/health_log_family_controller.dart';
import '../../health_log_my_self/controller/health_log_mySelf_controller.dart';

class HealthLogBottomSheet extends StatelessWidget {
  final bool isEdit;
  final bool isFamily;
  final String? healthLogId;

  HealthLogBottomSheet({
    super.key,
    this.isEdit = false,
    this.isFamily = true,
    this.healthLogId,
  });

  // Dynamically get the correct controller
  late final dynamic controller =
  isFamily ? Get.find<HealthLogFamilyController>() : Get.find<HealthLogMyselfController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w(20),
        vertical: Dimensions.h(20),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [

            Text(
              isEdit ? "Update Health Log" : "Add Health Log",
              style: AppTextStyles.body.copyWith(
                color: AppColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            /// Input Fields
            _buildInput(controller.familyMemberName, AppStrings.healthLogName.tr),
            _buildInput(controller.bloodPressure, "120/80", isNumber: false),
            _buildInput(controller.heartRate, "72", isNumber: true),
            _buildInput(controller.weight, "55", isNumber: true),
            _buildInput(controller.bloodSugar, "2.8", isNumber: true),

            SizedBox(height: Dimensions.h(20)),

            /// SUBMIT BUTTON
            GestureDetector(
              onTap: () {
                if (isEdit) {
                  controller.updateHealthLog(healthLogId!);
                } else {
                  controller.addHealthLog();
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    isEdit ? "Update Health Log" : AppStrings.addHealthLog.tr,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(20)),
          ],
        ),
      ),
    );
  }

  /// Reusable Input Field
  Widget _buildInput(TextEditingController ctrl, String hint, {bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(15)),
      child: HVTextField(
        controller: ctrl,
        hint: hint,
        keyboardType: isNumber ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      ),
    );
  }
}
