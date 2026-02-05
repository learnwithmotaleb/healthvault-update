import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../model/user_profile_model.dart';

class ProfileController extends GetxController {
  final menuItems = <ProfileMenuModel>[].obs;
  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;
  Rx<Data?> userData = Rx<Data?>(null);

  @override
  void onInit() {
    loadMenu();
    getUserProfile();
    super.onInit();
  }

  /// ===============================
  ///     GET User Profile API
  /// ===============================
  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.getUserProfile,
        isToken: true,
      );

      if (response.statusCode == 200) {
        try {
          final model = UserProfile.fromJson(response.body);

          if (model.success == true && model.data != null && model.data!.isNotEmpty) {
            userData.value = model.data!.first;   // Because API returns List<Data>
          } else {
            AppSnackBar.fail(model.message ?? "Something went wrong");
          }
        } catch (e) {
          AppSnackBar.fail("Parsing error: $e");
        }
      } else {
        AppSnackBar.fail("API Error: ${response.statusText}");
      }
    } catch (e) {
      AppSnackBar.fail("Network error: $e");
    } finally {
      isLoading.value = false;
    }
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
