import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_validation.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/role_controller/role_controller.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/assets_image/app_images.dart';
import '../../../../../../utils/static_strings/static_strings.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());
  final roleController = Get.put(RoleController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Header

                    Container(
                      height: 199,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.selectScreen),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            AppColors.loginImageOverColor.withOpacity(0.5), // adjust opacity
                            BlendMode.srcATop, // try multiply/darken for different looks
                          ),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    const SizedBox(height: 70),

                    /// Title & Subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.signIn.tr,
                            style: AppTextStyles.title.copyWith(
                                color: AppColors.primaryColor
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppStrings.signInSubTitle.tr,
                            style: AppTextStyles.body,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    /// Form
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Email
                            Text(AppStrings.email.tr, style: AppTextStyles.label),
                            const SizedBox(height: 8),
                            TextFormField(
                                controller: controller.emailController,
                                focusNode: controller.emailFocus,
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
                                    borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                                  ),  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                                ),
                                ),
                                validator: AppValidators.required()
                            ),

                            const SizedBox(height: 16),

                            /// Password
                            /// Password
                            Text(AppStrings.password.tr, style:AppTextStyles.label),
                            const SizedBox(height: 8),
                            Obx(
                                  () => TextFormField(
                                  controller: controller.passwordController,
                                  focusNode: controller.passwordFocus,
                                  obscureText: controller.isPasswordHidden.value, // reactive here
                                  decoration: InputDecoration(
                                    hintStyle: AppTextStyles.hint,
                                    hintText: AppStrings.enterYourPassword.tr,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordHidden.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColors.hintColor.withOpacity(0.5),
                                      ),
                                      onPressed: controller.togglePassword,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(color: AppColors.primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(color: AppColors.primaryColor),
                                    ),
                                  ),
                                  validator: AppValidators.required()
                              ),
                            ),
                            SizedBox(height: Dimensions.w(5),),


                            /// Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: (){
                                  Get.toNamed(RoutePath.forget);
                                },
                                child: Text(
                                  AppStrings.forgotPassword.tr,
                                  style: TextStyle(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),


                            Obx(() => HVButton(
                              label: controller.isLoading.value ? "" : AppStrings.signIn.tr,
                              onPressed: controller.isLoading.value ? null : controller.login,
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


                            /// Sign Up Text
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      AppStrings.dontHaveAnAccount.tr,
                                      style: AppTextStyles.body.copyWith(
                                          color: AppColors.hintColor
                                      )
                                  ),
                                  TextButton(
                                    onPressed: controller.signup,
                                    child: Text(
                                        AppStrings.signup.tr,
                                        style: AppTextStyles.body.copyWith(color: AppColors.primaryColor)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Circular Logo Overlay
              Positioned(
                top: 175,
                left: 20,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(width: 2,color: AppColors.loginLogoRadiusColor),
                      borderRadius: BorderRadius.circular(10)

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 0.5,
                      backgroundColor: AppColors.whiteColor,
                      child: Image.asset(AppImages.appLogo),

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
