import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';
import 'package:healthvault/presentation/widget/hv_validation.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../../core/routes/route_path.dart';
import '../../../../../../utils/static_strings/static_strings.dart';
import '../controller/reset_controller.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final ResetController controller = Get.put(ResetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(AppStrings.resetPassword.tr),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // New Password
                Text(AppStrings.newPassword.tr, style: AppTextStyles.label),
                SizedBox(height: Dimensions.h(16)),


                Obx(
                      () => TextFormField(
                    controller: controller.newPasswordController,
                    focusNode: controller.newPasswordFocus,
                    textInputAction: TextInputAction.next,
                    obscureText: controller.isNewPasswordHidden.value,
                    decoration: InputDecoration(
                      hintText: AppStrings.enterNewPassword.tr,
                      hintStyle: AppTextStyles.hint,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w(16), vertical: Dimensions.h(14)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.r(6))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isNewPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: controller.toggleNewPassword,
                      ),
                    ),
                    validator: AppValidators.required(),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(controller.confirmPasswordFocus);
                    },
                  ),
                ),

                SizedBox(height: Dimensions.h(20)),
                Text(AppStrings.confirmPassword.tr, style: AppTextStyles.label),
                SizedBox(height: Dimensions.h(16)),

                // Confirm Password
                Obx(
                      () => TextFormField(
                    controller: controller.confirmPasswordController,
                    focusNode: controller.confirmPasswordFocus,
                    textInputAction: TextInputAction.done,
                    obscureText: controller.isConfirmPasswordHidden.value,
                    decoration: InputDecoration(
                      hintText: AppStrings.confirmNewPassword.tr,
                      hintStyle: AppTextStyles.hint,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w(16), vertical: Dimensions.h(14)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.r(6))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: controller.toggleConfirmPassword,
                      ),
                    ),
                    validator: AppValidators.required(),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // Update Button
                Obx(
                      () => HVButton(
                    label: controller.isLoading.value
                        ? "Updating Password..."
                        : AppStrings.resetPassword.tr,
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                      await controller.resetPassword();
                    },
                    height: Dimensions.h(52),
                    width: double.infinity,
                  ),
                ),

                SizedBox(height: Dimensions.h(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
