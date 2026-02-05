import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/role_controller/role_controller.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../../registaration/controller/registration_controller.dart';
import '../../signup/controller/signup_controller.dart';

class IdentificationController extends GetxController {
  late final String email;
  late final String phone;
  late final String password;

  @override
  void onInit() {
    super.onInit();

    final signupCtrl = Get.find<SignupController>();

    email = signupCtrl.email.value;
    phone = signupCtrl.phone.value;
    password = signupCtrl.password.value;

    print("Email: $email");
    print("Phone: $phone");
    print("Password: $password");
  }
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

  /// Registration API call
  Future<void> registration() async {
    if (photo.value == null) {
      Get.snackbar("Error", "Please upload a photo first");
      return;
    }

    isLoading.value = true;

    try {
      print("=== Registration Started ===");
      print("API URL: ${ApiUrl.userRegister}");

      final api = ApiClient();

      final role = await RoleController().getRole();
      final registrationCtrl = Get.put(RegistrationController());

      //===Date Convert ISO===================
      String dobText = registrationCtrl.dateOfBirthController.text.trim();
      String dobIso = "${dobText}T00:00:00Z";

      /// Prepare fields for multipart
      final fields = {
        "fullName": registrationCtrl.fullNameController.text.trim(),
        "email": email.trim(),
        "phone": phone.trim(),
        "password": password.trim(),
        "role": role?.name ?? "",
        "dateOfBirth": dobIso,
        "gender": registrationCtrl.genderController.text.trim().toUpperCase(),
        "bloodGroup": registrationCtrl.bloodGroupController.text.trim(),
        "membershipId": registrationCtrl.membershipIDController.text.trim(),
        "address": registrationCtrl.addressController.text.trim(),
        "emergencyContact": registrationCtrl.emergencyContactController.text.trim(),
        "identificationNumber": registrationCtrl.identificationController.text.trim(),
      };

      /// Send multipart request
      final res = await api.multipart(
        url: ApiUrl.userRegister,
        fields: fields,
        files: [
          MultipartFileData(
            key: "profile_image",
            path: photo.value!.path,
          )
        ],
      );

      isLoading.value = false;

      if (res.statusCode == 201 && res.body["success"] == true) {
        Get.snackbar("Success", res.body["message"] ?? "User registered successfully");
        Get.toNamed(RoutePath.verification);
      } else {
        Get.snackbar("Error", res.body["message"] ?? "Failed to register user");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

}
