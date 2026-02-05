import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/routes/route_path.dart';
import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

class ChangePasswordController extends GetxController {
  final typePasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final typePasswordFocus = FocusNode();
  final newPasswordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  final isCurrentPasswordHidden = true.obs;
  final isNewPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  void toggleCurrentPassword() => isCurrentPasswordHidden.toggle();
  void toggleNewPassword() => isNewPasswordHidden.toggle();
  void toggleConfirmPassword() => isConfirmPasswordHidden.toggle();

  /// ====================== CHANGE PASSWORD ======================
  Future<void> changePassword() async {
    typePasswordFocus.unfocus();
    newPasswordFocus.unfocus();
    confirmPasswordFocus.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) return;

    final oldPassword = typePasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      AppSnackBar.fail("New password and confirm password do not match");
      return;
    }

    final token = await SharePrefsHelper.getToken();
    print("🔐 Token being sent: $token");

    try {
      isLoading.value = true;

      final api = ApiClient();

      final res = await api.post(
        url: ApiUrl.changePassword,
        body: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
        // Important: use isToken instead of isBasic
        isToken: true,
      );

      isLoading.value = false;

      print("📩 Change Password Response: ${res.body}");

      if (res.statusCode == 200 && res.body["success"] == true) {
        AppSnackBar.success(
            res.body["message"] ?? "Password changed successfully");

        /// Redirect back to profile
        Get.offNamed(RoutePath.bottomNav);
      } else {
        AppSnackBar.fail(res.body["message"] ?? "Failed to change password");
      }
    } catch (e) {
      isLoading.value = false;
      AppSnackBar.fail("Error: $e");
    }
  }

  @override
  void onClose() {
    typePasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    typePasswordFocus.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }
}
