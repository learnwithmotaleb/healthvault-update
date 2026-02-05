import 'package:get/get.dart';
import '../../core/routes/route_path.dart';
import '../../helper/local_db/local_db.dart';
import '../../helper/local_db/shareprefs_helper.dart';
import '../../helper/tost_message/show_snackbar.dart';

class AppNavigator {

  /// =================== Role Based Navigation ====================
  static Future<void> navigateAfterLogin() async {
    final role = (await SharePrefsHelper.getRole())?.toUpperCase() ?? "USER";

    print("🔍 User Role: $role");

    if (role == "PROVIDER") {
      Get.offAllNamed(RoutePath.providerNav);
    } else {
      Get.offAllNamed(RoutePath.bottomNav); // USER
    }
  }

  /// =================== Navigate By Stored Role ====================
  static Future<void> navigateByRole() async {
    final role = (await SharePrefsHelper.getRole())?.toUpperCase() ?? "USER";

    if (role == "PROVIDER") {
      Get.offAllNamed(RoutePath.providerNav);
    } else {
      Get.offAllNamed(RoutePath.bottomNav);
    }
  }

  /// =================== Initial Navigation (Splash) ====================
  static Future<void> checkAppStartNavigation() async {
    final token = SharePrefsHelper.getToken();
    final role  = (await SharePrefsHelper.getRole())?.toUpperCase() ?? "USER";

    if (token != null && token.isNotEmpty) {
      print("🔐 Token found: $token");

      if (role == "PROVIDER") {
        Get.offAllNamed(RoutePath.providerNav);
      } else {
        Get.offAllNamed(RoutePath.bottomNav); // USER
      }
    } else {
      print("❌ No token → Navigate to login");
      Get.offAllNamed(RoutePath.login);
    }
  }

  /// =================== Logout ====================
  static Future<void> logout() async {
    await SharePrefsHelper.clearAll();

    AppSnackBar.success("Logged out successfully");
    Get.offAllNamed(RoutePath.login);
  }

  /// =================== Force Screen Reload ====================
  static void refreshScreen() {
    Get.offAllNamed(Get.currentRoute);
  }

  /// =================== Debug Info ====================
  static Future<void> debugInfo() async {
    print("===== DEBUG INFO START =====");
    print("Token: ${await SharePrefsHelper.getToken()}");
    print("Role: ${await SharePrefsHelper.getRole()}");
    print("Current Route: ${Get.currentRoute}");
    print("===== DEBUG INFO END =====");
  }
}
