import 'dart:io';
import 'package:get/get.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

class FamilyMemberDocumentController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  /// API image list (FULL URL)
  final RxList<String> myFamilyImages = <String>[].obs;
  final Rxn<File> pickedImage = Rxn<File>();

  /// Base URL (for image render) - keep SAME as MySelf controller
  final String baseUrl = "${ApiUrl.mainDomain}/";

  @override
  void onInit() {
    super.onInit();
    getMyFamilyImages();
  }



  ///=================== PICK IMAGE ===================
  Future<void> pickImage() async {
    // Example using image_picker
    // final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (image != null) pickedImage.value = File(image.path);

    // Call upload after picking
    if (pickedImage.value != null) {
      uploadMyFamilyImage(pickedImage.value!);
    }
  }

  // ========================= ADD IMAGE (POST / MULTIPART) =========================
  Future<void> uploadMyFamilyImage(File image) async {
    final res = await _apiClient.uploadMedicalImage(
      url: ApiUrl.addDocumentFamily, // POST endpoint
      imageKey: "medical_family_image",
      imageFile: image,
      isToken: true,
    );

    if (res.isOk) {
      AppSnackBar.success("Image uploaded successfully");
      await getMyFamilyImages(); // Refresh list
    } else {
      AppSnackBar.fail(res.statusText ?? "Upload failed");
    }
  }

  // ========================= GET IMAGES =========================
  Future<void> getMyFamilyImages() async {
    final res = await _apiClient.getMedicalImages(
      url: ApiUrl.fetchDocumentFamily, // GET endpoint
      isToken: true,
    );

    if (res.isOk) {
      final data = res.body["data"];
      final List<String> rawImages =
      List<String>.from(data?["medical_family_image"] ?? []);

      // Convert backend paths to full URLs for UI
      myFamilyImages.value =
          rawImages.map((e) => baseUrl + e.replaceAll('\\', '/')).toList();
    } else {
      AppSnackBar.fail(res.statusText ?? "Failed to load images");
    }
  }

  // ========================= REMOVE IMAGE (PATCH JSON) =========================
  Future<void> removeMyFamilyImage(String fullImageUrl) async {
    // Convert full URL → backend relative path with double backslashes
    String relativePath = fullImageUrl.replaceFirst(baseUrl, '');
    relativePath = relativePath.replaceAll('/', r'\\');

    final res = await _apiClient.removeMedicalImage(
      url: ApiUrl.removeDocumentFamily, // PATCH endpoint
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
