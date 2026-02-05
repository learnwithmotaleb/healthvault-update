import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/screen/user/auth/forget/controller/forget_controller.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/local_db/local_db.dart';
import '../../../../../../helper/local_db/shareprefs_helper.dart';
import '../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';

class ResetController extends GetxController {
  /// Text controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Focus nodes
  final newPasswordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();


  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  /// Loading state
  var isLoading = false.obs;

  /// Form key
  final formKey = GlobalKey<FormState>();

  void toggleNewPassword() => isNewPasswordHidden.value = !isNewPasswordHidden.value;
  void toggleConfirmPassword() => isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  /// ====================== CHANGE PASSWORD ======================
  Future<void> resetPassword() async {
    newPasswordFocus.unfocus();
    confirmPasswordFocus.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) return;

    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      AppSnackBar.fail(title: "Health Vault","New password and confirm password do not match");
      return;
    }

    final token = await SharePrefsHelper.getToken();
    print("Token being sent: $token");

    try {
      isLoading.value = true;

      final api = ApiClient();

      final res = await api.post(
        url: ApiUrl.resetPassword,
        body: {
          "email": Get.put(ForgetController()).emailController.text.trim(),
          "newPassword": newPassword,
        },
        isBasic: false, // token auto-added
        isToken: false
      );

      isLoading.value = false;

      if (res.statusCode == 200 && res.body["success"] == true) {

       AppSnackBar.success(title: "Health Vault",res.body["message"] ?? "Password Reset successfully");
       Get.toNamed(RoutePath.login);



      } else {
        AppSnackBar.fail(title: "Reset Password",res.body["message"] ?? "Failed to Reset password");
      }
    } catch (e) {
      isLoading.value = false;
      AppSnackBar.fail(title: "Reset Password", "Error: $e");
    }
  }



  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }
}
