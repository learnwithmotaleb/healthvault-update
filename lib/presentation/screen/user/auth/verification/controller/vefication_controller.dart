import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/screen/user/auth/forget/controller/forget_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/signup/controller/signup_controller.dart';
import '../../../../../../helper/local_db/local_db.dart';
import '../../../../../../helper/local_db/shareprefs_helper.dart';
import '../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../core/routes/route_path.dart';

class VerificationController extends GetxController {
  /// OTP TextController and FocusNode
  final otpController = TextEditingController();
  final otpFocus = FocusNode();

  /// Loading state
  RxBool isLoading = false.obs;
  RxBool isLoadingResend = false.obs;

  /// ====================== VERIFY OTP ======================
  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length != 6) {
      AppSnackBar.fail(title: "Health Vault","Please enter a valid 6-digit OTP");
      return;
    }

    try {
      isLoading.value = true;

      final api = ApiClient();


      final res = await api.post(
        url: ApiUrl.verifyEmailOtp,
        body: {
          "email":Get.find<SignupController>().emailController.text,  // <-- Add email here
          "otp": otp,
        },
        isBasic: false,);

      isLoading.value = false;

      if (res.statusCode == 200 && res.body["success"] == true) {
        AppSnackBar.success(title: "OTP verification",res.body["message"] ?? "OTP verified successfully");
        Get.offAllNamed(RoutePath.login);
      } else {
        AppSnackBar.fail(title: "OTP verification",res.body["message"] ?? "OTP verification failed");
      }
    } catch (e) {
      isLoading.value = false;
      AppSnackBar.fail(title: "OTP verification", "Error: $e");
    }
  }


  /// ====================== RESEND OTP ======================
  Future<void> resendOtpProcess() async {
    try {
      isLoadingResend.value = true;

      final api = ApiClient();
      final token = await SharePrefsHelper.getToken();

      final res = await api.post(
        url: ApiUrl.resetPassword, // Make sure you have this URL in ApiUrl
        body: {}, // Pass any required fields for resend
        isBasic: false,
      );

      isLoadingResend.value = false;

      if (res.statusCode == 200 && res.body["success"] == true) {
        AppSnackBar.success(title: "OTP has been resent", res.body["message"] ?? "OTP has been resent");
      } else {
        AppSnackBar.fail(title: "OTP has been resent", res.body["message"] ?? "Failed to resend OTP");
      }
    } catch (e) {
      isLoadingResend.value = false;
      AppSnackBar.fail(title: "OTP has been resent", "Error: $e");
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    otpFocus.dispose();
    super.onClose();
  }
}
