import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../helper/local_db/local_db.dart';
import '../../../../../../helper/local_db/shareprefs_helper.dart';
import '../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../core/routes/route_path.dart';

class ForgetController extends GetxController {
  /// Text controller
  final emailController = TextEditingController();

  /// Form key
  final formKey = GlobalKey<FormState>();

  /// Loading state
  var isLoading = false.obs;

  /// ========================= FORGOT PASSWORD API =========================
  /// ========================= FORGOT PASSWORD API =========================
  Future<void> sendCode() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;

    try {
      final api = ApiClient();

      // Get token from shared preferences
      final token = await SharePrefsHelper.getToken();
      if (token == null) {
        isLoading.value = false;
        AppSnackBar.fail(title: "Health Vault","Token not found! Please login first.");
        return;
      }

      final res = await api.post(
        url: ApiUrl.forgetPassword, // {{LOCAL_URL}}/auth/forgot-password
        body: {
          "email": emailController.text.trim(),
        },
        isBasic: false, // Ensure it uses token
        // headers: token != null ? {"Authorization": "Bearer $token"} : null,

      );

      isLoading.value = false;

      if (res.statusCode == 200 && res.body["success"] == true) {
        AppSnackBar.success(title: "Health Vault", res.body["message"] ?? "Verification code sent!");

        // Navigate to verification screen
        Get.toNamed(RoutePath.verify);
      } else {
        AppSnackBar.fail(title: "Health Vault", res.body["message"] ?? "Failed to send code");
      }
    } catch (e) {
      isLoading.value = false;
      AppSnackBar.fail(title: "Health Vault", "Error: $e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
