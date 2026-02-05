import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

import 'package:healthvault/helper/tost_message/show_snackbar.dart';

class EditProfileController extends GetxController {

  final Apiclient = ApiClient();

  /// Text Controllers
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();

  /// Form key
  final formKey = GlobalKey<FormState>();

  /// Picked Image
  final Rx<File?> pickedImage = Rx<File?>(null);

  /// Loading
  final RxBool isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) pickedImage.value = File(image.path);
  }


  void updateProfile() async {

    if (pickedImage.value == null) {
      AppSnackBar.fail("Please select a profile image");
      return;
    }


    if (!formKey.currentState!.validate()) {
      AppSnackBar.fail("Please fill all required fields correctly");
      return;
    }

    Map<String, String> fields = {
      "fullName": nameController.text.trim(),
      "phone": numberController.text.trim(),
      "dateOfBirth": dateOfBirthController.text.trim(),
      "gender": genderController.text.toUpperCase().trim(),
    };

    final response = await Apiclient.patchWithMultipart(
      url: ApiUrl.updateMyProfile,
      fields: fields,
      imageFile: pickedImage.value,
      isToken: true, // Include Bearer token
    );

    if (response.statusCode == 200) {


      AppSnackBar.success("Profile updated successfully");
      Get.toNamed(RoutePath.login);


    } else {
      String errorMessage = "Failed to update profile";

      // Check if body is a Map and has message
      if (response.body is Map && response.body["message"] != null) {
        errorMessage = response.body["message"];
      }
      // Check for detailed errors (like duplicate field)
      else if (response.body is Map && response.body["error"] != null) {
        final errorList = response.body["error"];
        if (errorList is List && errorList.isNotEmpty) {
          errorMessage = errorList[0]["message"] ?? errorMessage;
        }
      }

      AppSnackBar.fail(errorMessage);
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
