import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/role_controller/role_controller.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/assets_image/app_images.dart';
import '../../../../../../utils/static_strings/static_strings.dart';
import '../controller/verify_controller.dart';
import '../widget/timer_widget.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  late final VerifyController controller;

  final roleController = Get.put(RoleController());


  @override
  void initState() {
    super.initState();
    controller = Get.put(VerifyController());
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title:  Text(AppStrings.verification.tr,),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h(5)),
            Center(
              child: Text(
                AppStrings.verifyYourAccount.tr,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.normal
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(12)),

            Center(
              child: Text(
                AppStrings.verifyYourAccountSubTitle.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
            ),

            SizedBox(height: Dimensions.h(40)),

            Center(
              child: Image.asset(
                AppImages.verificationImage,
                width: Dimensions.w(170),
                height: Dimensions.h(150),
              ),
            ),

            SizedBox(height: Dimensions.h(40)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,

                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(Dimensions.r(8)),
                  fieldHeight: Dimensions.h(48),
                  fieldWidth: Dimensions.w(46),

                  borderWidth: 1,
                  activeColor: AppColors.primaryColor,
                  selectedColor: AppColors.primaryColor,
                  inactiveColor: AppColors.primaryColor,
                  activeFillColor: AppColors.primaryColor
                ),

                onCompleted: (v) => print("OTP Completed $v"),
                beforeTextPaste: (_) => true,
              ),
            ),

            SizedBox(height: Dimensions.h(10)),

            Center(
              child: TimerWidget(
                onResendCode: controller.resendOtpProcess,
              ),
            ),

            SizedBox(height: Dimensions.h(50)),

            HVButton(
              label: AppStrings.verifyCode.tr,
              onPressed: () {
                controller.emailVerifyProcess();
              },
            ),

            SizedBox(height: Dimensions.h(20)),
          ],
        ),
      ),
    );
  }
}
