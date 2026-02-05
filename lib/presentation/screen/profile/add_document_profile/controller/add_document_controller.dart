import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../document_profile/model/media_model.dart';

class AddDocumentController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxList<String> mySelfImages = <String>[].obs;
  final RxList<String> familyImages = <String>[].obs;

  final String baseUrl = "${ApiUrl.mainDomain}/";

  @override
  void onInit() {
    super.onInit();
    getImages();
  }

  Future<void> getImages() async {
    final res = await _apiClient.getMedicalImages(
      url: ApiUrl.getProfileDocumentMySelf,
      isToken: true,
    );

    if (!res.isOk) {
      AppSnackBar.fail("Failed to load images");
      return;
    }

    final doc = MedicalDocument.fromJson(res.body);

    mySelfImages.value = doc.mySelfImages
        .map((e) => baseUrl + e.replaceAll('\\', '/'))
        .toList();

    familyImages.value = doc.familyImages
        .map((e) => baseUrl + e.replaceAll('\\', '/'))
        .toList();
  }

  Future<void> uploadMySelfImage(File image) async {
    final res = await _apiClient.uploadMedicalImage(
      url: ApiUrl.patchProfileDocumentMySelf,
      imageKey: "medical_mySelf_image",
      imageFile: image,
      isToken: true,
    );

    if (res.isOk) getImages();
  }

  Future<void> removeMySelfImage(String fullUrl) async {
    final path = fullUrl.replaceFirst(baseUrl, '');

    final res = await _apiClient.removeMedicalImage(
      url: ApiUrl.patchProfileDocumentMySelf,
      isToken: true,
      body: {
        "deleteMedical_mySelf_image": [path],
      },
    );

    if (res.isOk) {
      mySelfImages.remove(fullUrl);
    }
  }
}
