import 'dart:io';
import 'package:get/get.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

class FamilyMemberDocumentController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  /// API image list (FULL URL)
  final RxList<String> myFamilyImages = <String>[].obs;

  /// Base URL (for image render) - keep SAME as MySelf controller
  final String baseUrl = "${ApiUrl.mainDomain}/";

  @override
  void onInit() {
    super.onInit();
    getMyFamilyImages();
  }

  // ========================= ADD IMAGE (PATCH + MULTIPART) =========================
  Future<void> uploadMyFamilyImage(File image) async {
    final res = await _apiClient.uploadMedicalImage(
      url: ApiUrl.patchProfileDocumentFamilyMember,
      imageKey: "medical_family_image",
      imageFile: image,
      isToken: true,
    );

    if (res.isOk) {
      AppSnackBar.success("Image uploaded successfully");
      await getMyFamilyImages();
    } else {
      AppSnackBar.fail(res.statusText ?? "Upload failed");
    }
  }

  // ========================= GET IMAGES =========================
  Future<void> getMyFamilyImages() async {
    final res = await _apiClient.getMedicalImages(
      url: ApiUrl.getProfileDocumentFamilyMember,
      isToken: true,
    );

    if (res.isOk) {
      final data = res.body["data"];

      final List<String> rawImages =
      List<String>.from(data?["medical_family_image"] ?? []);

      myFamilyImages.value = rawImages
          .map((e) => baseUrl + e.replaceAll('\\', '/'))
          .toList();
    } else {
      AppSnackBar.fail(res.statusText ?? "Failed to load images");
    }
  }

  // ========================= REMOVE IMAGE (PATCH JSON) =========================
  Future<void> removeMyFamilyImage(String fullImageUrl) async {
    final relativePath = fullImageUrl.replaceFirst(baseUrl, '');

    final res = await _apiClient.removeMedicalImage(
      url: ApiUrl.removeProfileDocumentFamilyMember,
      isToken: true,
      body: {
        "deleteMedical_family_image": [relativePath],
      },
    );

    if (res.isOk) {
      myFamilyImages.remove(fullImageUrl);
      AppSnackBar.success("Image removed successfully");
    } else {
      AppSnackBar.fail(res.statusText ?? "Remove failed");
    }
  }
}
