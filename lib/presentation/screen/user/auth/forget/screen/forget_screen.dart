import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_validation.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import '../../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/static_strings/static_strings.dart';

import '../controller/forget_controller.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  late final ForgetController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ForgetController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading:  BackButton(),
        centerTitle: true,
        title:  Text(AppStrings.forgetPassword.tr,),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppStrings.forgetPasswordSubTitle.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
            ),
            SizedBox(height: Dimensions.h(20)),

            // Instruction / Title
            Center(
              child: Text(
                AppStrings.forgetPassword.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.normal
                ),
              ),
            ),
            SizedBox(height: Dimensions.h(30)),

            // Form
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.email.tr, ),
                  SizedBox(height: Dimensions.h(10)),
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: AppStrings.enterYourEmail.tr,
                      hintStyle: AppTextStyles.hint,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w(16), vertical: Dimensions.h(14)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                    validator: AppValidators.required()
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h(80)),

            // Send Code Button
            HVButton(
              label: AppStrings.sendCode.tr,
              onPressed: () {
                controller.sendCode();
              },
              height: Dimensions.h(52),
              width: double.infinity,
            ),
            SizedBox(height: Dimensions.h(20)),
          ],
        ),
      ),
    );
  }
}
