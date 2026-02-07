import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

class FamilyMemberDocumentController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _picker = ImagePicker();

  /// Base URL for rendering images
  final String baseUrl = "${ApiUrl.mainDomain}/";

  /// ==================== MySelf Images ====================
  final RxList<String> mySelfImages = <String>[].obs;
  final Rxn<File> pickedMySelfImage = Rxn<File>();

  /// ==================== Family Images ====================
  final RxList<String> familyImages = <String>[].obs;
  final Rxn<File> pickedFamilyImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    getFamilyImages();
  }

  // ==================== PICK IMAGE ====================
  Future<void> pickMySelfImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      final file = File(image.path);
      pickedMySelfImage.value = file;
      await uploadFamilyImage(file);
    }
  }

  Future<void> pickFamilyImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      final file = File(image.path);
      pickedFamilyImage.value = file;
      await uploadFamilyImage(file);
    }
  }


  Future<void> getFamilyImages() async {
    final res = await _apiClient.patch(
      url: ApiUrl.fetchDocumentFamily,
      body: {},
      isToken: true,
    );

    if (res.isOk) {
      final data = res.body["data"];
      familyImages.value = (data?["medical_family_image"] ?? [])
          .map<String>((e) => baseUrl + e.replaceAll('\\', '/'))
          .toList();
    } else {
      AppSnackBar.fail("Failed to load Family images");
    }
  }


  Future<void> uploadFamilyImage(File image) async {
    final res = await _apiClient.uploadMedicalImage(
      url: ApiUrl.addDocumentFamily,
      imageKey: "medical_family_image",
      imageFile: image,
      isToken: true,
    );

    if (res.isOk) {
      AppSnackBar.success("Family image uploaded successfully");
      pickedFamilyImage.value = null;
      await getFamilyImages();
    } else {
      AppSnackBar.fail("Failed to upload Family image");
    }
  }



  Future<void> removeFamilyImage(String fullUrl) async {
    String path = fullUrl.replaceFirst(baseUrl, '').replaceAll('/', r'\\');

    final res = await _apiClient.removeMedicalImage(
      url: ApiUrl.removeDocumentFamily,
      isToken: true,
      body: {"deleteMedical_family_image": [path]},
    );

    if (res.isOk) {
      familyImages.remove(fullUrl);
      AppSnackBar.success("Family image removed successfully");
    } else {
      AppSnackBar.fail("Failed to remove Family image");
    }
  }
}
