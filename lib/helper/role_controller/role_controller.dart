
// lib/core/role_controller.dart
import 'package:shared_preferences/shared_preferences.dart';

enum AppRole { NORMALUSER, PROVIDER }

class RoleController {
  static const _key = 'role'; // "user" | "provider"

  /// Save role (user/provider)
  Future<void> setRole(AppRole role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, role.name);
  }

  /// Convenience
  Future<void> setUser() => setRole(AppRole.NORMALUSER);
  Future<void> setProvider() => setRole(AppRole.PROVIDER);

  /// Read role (null if not set)
  Future<AppRole?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_key);
    if (v == null) return null;
    return AppRole.values.firstWhere((e) => e.name == v, orElse: () => AppRole.NORMALUSER);
  }

  /// Helpers
  Future<bool> isUser() async => (await getRole()) == AppRole.NORMALUSER;
  Future<bool> isProvider() async => (await getRole()) == AppRole.PROVIDER;

  /// Clear (optional)
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AppStorage {
//   static const String _roleKey = "app_role";   // USER | PROVIDER
//   static const String _tokenKey = "user_token";
//
//   /// ===================== SAVE DATA ======================
//   static Future<void> saveRole(String role) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_roleKey, role.toUpperCase()); // Store in CAPITAL
//   }
//
//   static Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//   }
//
//   /// ===================== READ DATA ======================
//   static Future<String?> getRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_roleKey);
//   }
//
//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }
//
//   /// ===================== REMOVE DATA ======================
//   static Future<void> clearAll() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_roleKey);
//     await prefs.remove(_tokenKey);
//   }
// }
