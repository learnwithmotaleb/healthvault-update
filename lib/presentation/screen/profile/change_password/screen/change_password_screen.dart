import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';

import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.changePassword.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Current Password
                    _title(AppStrings.password.tr),
                    _passwordField(
                      controller: controller.typePasswordController,
                      focusNode: controller.typePasswordFocus,
                      hint: AppStrings.enterYourPassword.tr,
                      isHidden: controller.isCurrentPasswordHidden,
                      onToggle: controller.toggleCurrentPassword,
                      onSubmit: () =>
                          controller.newPasswordFocus.requestFocus(),
                    ),

                    SizedBox(height: Dimensions.h(16)),

                    /// New Password
                    _title(AppStrings.newPassword.tr),
                    _passwordField(
                      controller: controller.newPasswordController,
                      focusNode: controller.newPasswordFocus,
                      hint: AppStrings.enterYourNewPassword.tr,
                      isHidden: controller.isNewPasswordHidden,
                      onToggle: controller.toggleNewPassword,
                      onSubmit: () =>
                          controller.confirmPasswordFocus.requestFocus(),
                    ),

                    SizedBox(height: Dimensions.h(16)),

                    /// Confirm Password
                    _title(AppStrings.confirmPassword.tr),
                    _passwordField(
                      controller: controller.confirmPasswordController,
                      focusNode: controller.confirmPasswordFocus,
                      hint: AppStrings.confirmPassword.tr,
                      isHidden: controller.isConfirmPasswordHidden,
                      onToggle: controller.toggleConfirmPassword,
                      onSubmit: controller.changePassword,
                      isConfirm: true,
                    ),

                    SizedBox(height: Dimensions.h(40)),


                    Obx(() => HVButton(
                      label: controller.isLoading.value ? "" : AppStrings.update.tr,
                      onPressed: controller.isLoading.value ? null : controller.changePassword,
                      height: 52,
                      width: double.infinity,
                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          strokeWidth: 2.5,
                        ),
                      )
                          : null,
                    )),



                    SizedBox(height: Dimensions.h(24)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable title
  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: AppTextStyles.body),
    );
  }

  /// Reusable password field (with eye icon)
  Widget _passwordField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required RxBool isHidden,
    required VoidCallback onToggle,
    required VoidCallback onSubmit,
    bool isConfirm = false,
  }) {
    return Obx(
          () => TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isHidden.value,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          suffixIcon: IconButton(
            splashRadius: 20,
            icon: Icon(
              isHidden.value
                  ? CupertinoIcons.eye_slash
                  : CupertinoIcons.eye,
              color: AppColors.primaryColor,
            ),
            onPressed: onToggle,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password cannot be empty";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          if (isConfirm &&
              value != this.controller.newPasswordController.text) {
            return "Passwords do not match";
          }
          return null;
        },
        onFieldSubmitted: (_) => onSubmit(),
      ),
    );
  }
}
