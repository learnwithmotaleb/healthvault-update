import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/screen/user/auth/forget/controller/forget_controller.dart';

import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';

class VerifyController extends GetxController{

  final otpController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingResend = false.obs;

  Future<void> emailVerifyProcess() async {
    final otp = otpController.text.trim();
    if (otp.length != 6) {
      AppSnackBar.fail(title: "OTP verification","Please enter a valid 6-digit OTP");
      return;
    }

    try {
      isLoading.value = true;

      final api = ApiClient();


      final res = await api.post(
        url: ApiUrl.verifyOtp,
        isToken: false,
        body: {
          "email":Get.find<ForgetController>().emailController.text,  // <-- Add email here
          "otp": otp,
        },
        isBasic: false,);

      isLoading.value = false;

      if (res.statusCode == 200 && res.body["success"] == true) {
        AppSnackBar.success( title: "OTP verified",  res.body["message"] ?? "OTP verified successfully");
        Get.toNamed(RoutePath.reset);
      } else {
        AppSnackBar.fail(title: "OTP verification",res.body["message"] ?? "OTP verification failed");
      }
    } catch (e) {
      isLoading.value = false;
      AppSnackBar.fail(title: "OTP verified", "Error: $e");
    }
  }

  resendOtpProcess() async {
    // return await AuthService.resendOtpService(
    //   isLoading: isLoadingResend,
    //   email: Get.find<ForgotController>().emailController.text,
    // );
  }

  @override
  void onClose() {
    // Dispose controllers & focus nodes to prevent memory leaks
    otpController.dispose();
    super.onClose();
  }

}