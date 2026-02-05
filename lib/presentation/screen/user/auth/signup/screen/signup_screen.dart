import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_validation.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/role_controller/role_controller.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/static_strings/static_strings.dart';

import '../../../../../widget/hv_text_field.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = Get.put(SignupController());




  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title:  Text(AppStrings.signup.tr),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.signup.tr, style: AppTextStyles.title),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.signupSubTitle.tr,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 10),

            /// Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.fullName.tr, style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.fullNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.hint,
                        hintText: AppStrings.enterYourName.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      validator: AppValidators.required(),
                    ),
                    const SizedBox(height: 16),

                    /// Email
                    Text(AppStrings.email.tr, style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.hint,
                        hintText: AppStrings.enterYourEmail.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      validator: AppValidators.required(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.phoneNumber.tr,
                      style: AppTextStyles.label,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.hint,
                        hintText: AppStrings.enterYourPhone.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      validator: AppValidators.required(),
                    ),
                    const SizedBox(height: 16),

                    /// Password
                    Text(AppStrings.password.tr, style: AppTextStyles.label),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.hint,
                        hintText: AppStrings.enterYourPassword.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      validator: AppValidators.required(),
                    ),

                     SizedBox(height: Dimensions.h(16)),

                    /// Confirm Password
                    Text(
                      AppStrings.confirmPassword.tr,
                      style: AppTextStyles.label,
                    ),
                    SizedBox(height: Dimensions.h(8)),

                    TextFormField(
                      controller: controller.confirmPasswordController,
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.hint,
                        hintText: AppStrings.enterYourPassword.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      validator: AppValidators.required(),
                    ),
                    SizedBox(height: Dimensions.h(16)),


                  CheckboxListTile(
                    title: Text(
                     AppStrings.iHaveReadAndAgreeTo.tr,
                      style: AppTextStyles.hint.copyWith(fontSize: 12),
                    ),
                    value: isChecked, // Replace with your state variable
                    checkColor: AppColors.whiteColor, // Tick color
                    activeColor: AppColors.primaryColor,  // Fill color when checked
                    onChanged: (value) {
                      isChecked = value!;
                      setState(() {

                      });


                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),

                    SizedBox(height: Dimensions.h(30)),

                    /// Login Button
                    HVButton(
                      label: AppStrings.signup.tr,

                      onPressed: () async {
                        await controller.signup(); // optional image

                      },

                      height: 52,
                      width: double.infinity,
                    ),
                    SizedBox(height: Dimensions.h(10)),

                    /// Sign Up Text
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dontHaveAnAccount.tr,
                            style: AppTextStyles.hint,
                          ),
                          TextButton(
                            onPressed: (){
                              Get.toNamed(RoutePath.login);
                            },
                            child: Text(
                              AppStrings.signIn.tr,
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h(16)),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
