import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../helper/local_db/local_db.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../helper/local_db/shareprefs_helper.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import '../../profile/model/user_profile_model.dart';

class EditProfileController extends GetxController {

  final apiClient = ApiClient();

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final Rx<File?> pickedImage = Rx<File?>(null);
  var existingImageUrl = ''.obs;
  final RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  String get savedRole => SharePrefsHelper.getRole()?.toUpperCase() ?? "";
  bool get isProvider => savedRole == "PROVIDER";
  bool get isNormalUser => savedRole == "NORMALUSER";

  @override
  void onInit() {
    super.onInit();
    loadExistingProfile();
  }

  Future<void> loadExistingProfile() async {
    try {
      isLoading.value = true;

      final url = isProvider
          ? ApiUrl.getProviderProfile
          : ApiUrl.getUserProfile;

      final response = await apiClient.get(url: url, isToken: true);
      print("📦 EditProfile Response: ${response.body}");

      if (response.statusCode == 200) {
        final body = response.body;

        if (body["success"] == true && body["data"] != null) {
          final data = body["data"];
          ProfileData? profile;

          if (data is List && data.isNotEmpty) {
            final userMap = data[0] as Map<String, dynamic>;

            if (isNormalUser) {
              final details = (userMap["normalUserDetails"] as List?)
                  ?.isNotEmpty == true
                  ? userMap["normalUserDetails"][0] as Map<String, dynamic>
                  : <String, dynamic>{};

              final merged = {
                ...userMap,
                ...details,
                "profile_image": details["profile_image"] ?? "",
              };
              profile = ProfileData.fromJson(merged);

            } else if (isProvider) {
              final details = (userMap["providerDetails"] as List?)
                  ?.isNotEmpty == true
                  ? userMap["providerDetails"][0] as Map<String, dynamic>
                  : <String, dynamic>{};

              final merged = {
                ...userMap,
                ...details,
                "profile_image": details["profile_image"] ?? "",
              };
              profile = ProfileData.fromJson(merged);
            }

          } else if (data is Map<String, dynamic>) {
            profile = ProfileData.fromJson(data);
          }

          if (profile != null) {
            nameController.text = profile.fullName ?? "";
            genderController.text = profile.gender ?? "";
            numberController.text = profile.emergencyContact ?? "";

            if (profile.dateOfBirth != null) {
              dateOfBirthController.text =
                  profile.dateOfBirth!.split("T").first;
            }

            // ✅ Fix backslash before building URL
            if (profile.profileImage != null &&
                profile.profileImage!.isNotEmpty) {
              final cleanPath = profile.profileImage!
                  .replaceAll('\\\\', '/')  // handles \\
                  .replaceAll('\\', '/');   // handles \

              existingImageUrl.value =
              "${ApiUrl.mainDomain}/$cleanPath";

              print("🖼 Image URL: ${existingImageUrl.value}");
            }

            print("✅ Pre-filled: ${profile.fullName} | ${profile.gender} | ${profile.dateOfBirth}");
          }
        } else {
          AppSnackBar.fail(body["message"] ?? "Failed to load profile");
        }
      } else {
        AppSnackBar.fail("Failed to load profile");
      }
    } catch (e) {
      print("❌ loadExistingProfile error: $e");
      AppSnackBar.fail("Error loading profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      pickedImage.value = File(image.path);
      existingImageUrl.value = "";
    }
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) {
      AppSnackBar.fail("Please fill all required fields correctly");
      return;
    }

    try {
      isLoading.value = true;

      // ✅ ONLY these 3 fields — backend schema accepts nothing else
      final Map<String, String> fields = {
        "fullName": nameController.text.trim(),
        "dateOfBirth": dateOfBirthController.text.trim(),
        "gender": genderController.text.toUpperCase().trim(),
      };

      print("📤 Sending fields: $fields"); // ✅ verify in console

      final response = await apiClient.patchWithMultipart(
        url: ApiUrl.updateMyProfile,
        fields: fields,
        imageFile: pickedImage.value,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        AppSnackBar.success("Profile updated successfully");
        await Future.delayed(const Duration(milliseconds: 300));
        Get.back();
        return;
      } else {
        String errorMessage = "Failed to update profile";
        if (response.body is Map && response.body["message"] != null) {
          errorMessage = response.body["message"];
        } else if (response.body is Map && response.body["error"] != null) {
          final errorList = response.body["error"];
          if (errorList is List && errorList.isNotEmpty) {
            errorMessage = errorList[0]["message"] ?? errorMessage;
          }
        }
        AppSnackBar.fail(errorMessage);
      }
    } catch (e) {
      AppSnackBar.fail("Error updating profile: $e");
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    nameController.dispose();
    numberController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
    super.onClose();
  }
}