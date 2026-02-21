import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/local_db/shareprefs_helper.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../model/user_profile_model.dart'; // ✅ updated import

class ProfileController extends GetxController {
  final menuItems = <ProfileMenuModel>[].obs;
  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;

  Rx<ProfileData?> profileData = Rx<ProfileData?>(null);

  // ✅ Role from SharedPreferences — same as HomeController
  String get savedRole => SharePrefsHelper.getRole()?.toUpperCase() ?? "";
  bool get isProvider => savedRole == "PROVIDER";
  bool get isNormalUser => savedRole == "NORMALUSER";

  // ✅ Helper getters
  String get fullName => profileData.value?.fullName ?? "";
  String get role => savedRole;
  String get fullImageUrl {
    final raw = profileData.value?.profileImage ?? "";
    return raw.isNotEmpty ? ApiUrl.buildImageUrl(raw) : "";
  }

  @override
  void onInit() {
    super.onInit();
    loadMenu();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;

      // ✅ Use correct endpoint based on role
      final url = isProvider
          ? ApiUrl.getProviderProfile
          : ApiUrl.getUserProfile;

      final response = await apiClient.get(url: url, isToken: true);

      print("📦 Profile Response: ${response.body}");

      if (response.statusCode == 200) {
        final body = response.body;

        if (body["success"] == true && body["data"] != null) {
          final data = body["data"];

          if (data is List && data.isNotEmpty) {
            final userMap = data[0] as Map<String, dynamic>;

            if (isNormalUser) {
              // ✅ Merge top-level + normalUserDetails[0]
              final details = (userMap["normalUserDetails"] as List?)?.isNotEmpty == true
                  ? userMap["normalUserDetails"][0] as Map<String, dynamic>
                  : <String, dynamic>{};

              final merged = {
                ...userMap,
                ...details,
                "profile_image": details["profile_image"] ?? "",
              };

              profileData.value = ProfileData.fromJson(merged);

            } else if (isProvider) {
              // ✅ Merge top-level + providerDetails[0]
              final details = (userMap["providerDetails"] as List?)?.isNotEmpty == true
                  ? userMap["providerDetails"][0] as Map<String, dynamic>
                  : <String, dynamic>{};

              final merged = {
                ...userMap,
                ...details,
                "profile_image": details["profile_image"] ?? "",
              };

              profileData.value = ProfileData.fromJson(merged);
            }

          } else if (data is Map<String, dynamic>) {
            // ✅ Fallback: data is a plain object
            profileData.value = ProfileData.fromJson(data);
          }

        } else {
          AppSnackBar.fail(body["message"] ?? "Something went wrong");
        }
      } else {
        AppSnackBar.fail("API Error: ${response.statusText}");
      }
    } catch (e) {
      print("❌ getUserProfile error: $e");
      AppSnackBar.fail("Network error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProfile() async {
    await getUserProfile();
  }

  void loadMenu() {
    menuItems.value = [
      ProfileMenuModel(Icons.settings, AppStrings.accountSetting),
      ProfileMenuModel(Icons.post_add, "AppStrings.myPost"),
      ProfileMenuModel(Icons.timer, "AppStrings.myAccepted"),
      ProfileMenuModel(Icons.public, AppStrings.publicProfileInfo),
      ProfileMenuModel(Icons.history, AppStrings.history),
      ProfileMenuModel(Icons.notifications, AppStrings.notification),
      ProfileMenuModel(Icons.language, AppStrings.language),
      ProfileMenuModel(Icons.question_mark_rounded, AppStrings.faq),
      ProfileMenuModel(Icons.contact_page_rounded, AppStrings.contactUs),
      ProfileMenuModel(Icons.library_books_sharp, AppStrings.termsAndCondition),
      ProfileMenuModel(Icons.privacy_tip_outlined, AppStrings.privacyPolicy),
      ProfileMenuModel(Icons.logout, AppStrings.logOut),
    ];
  }
}

class ProfileMenuModel {
  final IconData icon;
  final String title;

  ProfileMenuModel(this.icon, this.title);
}