import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../user/auth/signup/controller/signup_controller.dart';

class MedicalLicenseController extends GetxController{

  /// Form key for validation
  final formKey = GlobalKey<FormState>();

  /// Loading state
  final isLoading = false.obs;

  /// Image picker
  final ImagePicker _picker = ImagePicker();

  /// Observable photo
  Rx<XFile?> photo = Rx<XFile?>(null);

  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    try {
      final result = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );
      if (result != null) photo.value = result;
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  /// Remove selected photo
  void removePhoto() => photo.value = null;

}