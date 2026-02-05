import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/static_strings/static_strings.dart';

import '../../verify/widget/timer_widget.dart';
import '../controller/vefication_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {


  late final VerificationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(VerificationController());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title:  Text(AppStrings.verification.tr),
        elevation: 0,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        AppStrings.verifyYourAccount.tr,
                          style: AppTextStyles.title.copyWith(
                            fontWeight: FontWeight.normal

                          )
                      ),
                    ),
                    SizedBox(height: Dimensions.h(12)),
                    Center(
                      child: Text(
                        AppStrings.verifyYourAccountSubTitle.tr,
                        textAlign: TextAlign.center,
                        style:TextStyle(

                      ),
                      ),
                    ),

                    SizedBox(height: Dimensions.h(60)),

                    // OTP Field
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16),vertical:Dimensions.w(5) ),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: controller.otpController,
                        focusNode: controller.otpFocus,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(Dimensions.r(8)),
                          fieldHeight: Dimensions.h(51),
                          fieldWidth: Dimensions.w(50),
                          borderWidth: 1,
                          activeColor: AppColors.primaryColor,
                          selectedColor: AppColors.primaryColor,
                          inactiveColor: AppColors.primaryColor,
                        ),
                        onCompleted: (v) {
                          print("OTP Completed: $v");
                          controller.otpFocus.unfocus();
                        },
                        beforeTextPaste: (_) => true,
                      ),
                    ),

                    SizedBox(height: Dimensions.h(10)),

                    // Timer & Resend
                    Center(
                      child: TimerWidget(
                        onResendCode: controller.resendOtpProcess,
                      ),
                    ),

                    SizedBox(height: Dimensions.h(50)),


                    // Verify Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                      child: HVButton(
                        label: AppStrings.verifyCode.tr,
                        onPressed: () {
                          controller.verifyOtp();
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
          );
        },
      ),
    );
  }
}
