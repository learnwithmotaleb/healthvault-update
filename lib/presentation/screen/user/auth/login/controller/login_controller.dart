import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/local_db/local_db.dart';
import '../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../helper/local_db/shareprefs_helper.dart';
import '../../../../../global_navigation_maneger/golobal_navigation_menegar.dart';

class LoginController extends GetxController {
  /// Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Focus nodes
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  /// Rx variables
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  /// Form key
  final formKey = GlobalKey<FormState>();

  /// Toggle password visibility
  void togglePassword() => isPasswordHidden.value = !isPasswordHidden.value;

  /// ========================= LOGIN API =========================
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final api = ApiClient();

      final res = await api.post(
        url: ApiUrl.userLogin,
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      isLoading.value = false;

      if (res.statusCode == 200 && res.body["success"] == true) {
        final data = res.body["data"] ?? {};

        // ------------------ Token ------------------
        final token = (data["accessToken"] as String?)?.trim();
        if (token == null || token.isEmpty) {
          AppSnackBar.fail(title: "Health Vault","Invalid login response!");
          return;
        }
        await SharePrefsHelper.saveToken(token);
        print("✅ Token saved: ${await SharePrefsHelper.getToken()}");

        // ------------------ Role ------------------
        final rawRole = (data["jwtPayload"]?["role"] as String?) ?? "USER";
        final role = rawRole.toUpperCase();  // Always CAPITAL
        await SharePrefsHelper.saveRole(role);
        print("✅ Role saved: ${await SharePrefsHelper.getRole()}");

        // ------------------ User ID ------------------
        final userId = (data["jwtPayload"]?["id"] as String?)?.trim();

        if (userId != null && userId.isNotEmpty) {
          await SharePrefsHelper.saveUserId(userId);
          print("✅ User ID saved: ${await SharePrefsHelper.getUserId()}");
        } else {
          print("⚠️ User ID missing in response");
        }


        final profileId = (data["jwtPayload"]?["profileId"] as String?)?.trim();
        if (profileId != null && profileId.isNotEmpty) {
          await SharePrefsHelper.saveProfileId(profileId);
          print("✅ Profile ID saved: ${await SharePrefsHelper.getProfileId()}");
        } else {
          print("⚠️ Profile ID missing in response");
        }

        // ------------------ Success ------------------
        AppSnackBar.success(title: "Health Vault","Login Successful");

        // ------------------ Navigation ------------------
        AppNavigator.navigateByRole();

      } else {
        AppSnackBar.fail(title: "Health Vault",res.body["message"] ?? "Login Failed");
      }

    } catch (e) {
      isLoading.value = false;
      AppSnackBar.fail(title: "Health Vault", "Error: $e");
      print("⚠️ Login Error: $e");
    }
  }



  void forgotPassword() {
    AppSnackBar.info(title: "Forget Password","Redirecting to forgot password...");
  }

  void signup() {
    Get.toNamed(RoutePath.signup);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
