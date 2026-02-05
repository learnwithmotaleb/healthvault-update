import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/helper/local_db/local_db.dart';
import 'package:healthvault/presentation/screen/category_screen/pharmacy/controller/pharmacy_controller.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/controller/doctor_indentification_controller.dart';
import 'package:healthvault/presentation/screen/provider/medical_license/controller/medical_license_controller.dart';
import 'package:healthvault/presentation/screen/provider/pharmacy_identification/controller/pharmacy_identification_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/routes/route_path.dart';
import '../../../../../helper/role_controller/role_controller.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../user/auth/registaration/controller/registration_controller.dart';
import '../../../user/auth/signup/controller/signup_controller.dart';
import '../../doctor_identification/controller/service_selection_controller.dart';

class PassportIdentificationController extends GetxController {

  late DoctorIdentificationController doctorController;
  late PharmacyIdentificationController pharmacyController = Get.put(PharmacyIdentificationController());


  late final String name;
  late final String email;
  late final String phone;
  late final String password;

  late final String providerTypeId;
  late final String providerTypeKey;
  late final String providerTypeLabel;
  XFile? profilePhoto; // final photo file
  Rx<XFile?> photoForIdentification =Rx<XFile?>(null);


  late final String serviceId;
  late final String serviceTitle;
  late final String servicePrice;

  AppRole? role;




  //=======================================================
  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    try {
      final result = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );
      if (result != null) photoForIdentification.value = result;
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  /// Remove selected photo
  void removePhoto() => photoForIdentification.value = null;
  //=======================================================


  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRole();
    // ✅ Get the existing controller instead of creating a new one
    doctorController = Get.find<DoctorIdentificationController>();
    pharmacyController = Get.find<PharmacyIdentificationController>();
    
    
    final signupCtrl = Get.find<SignupController>();
    final medicalCtrl = Get.find<MedicalLicenseController>();
    final serviceCtrl = Get.find<ServiceSelectionController>();



    name = signupCtrl.name.value;
    email = signupCtrl.email.value;
    phone = signupCtrl.phone.value;
    password = signupCtrl.password.value;

    providerTypeId = signupCtrl.selectedProviderId.value;
    providerTypeKey = signupCtrl.selectedProviderKey.value;
    providerTypeLabel = signupCtrl.selectedProviderLabel.value;

    /// Receive image from MedicalLicenseController
    profilePhoto = medicalCtrl.photo.value;

    //===============


    print("---- RECEIVED FROM SIGNUP ----");
    print("Name: $name");
    print("Email: $email");
    print("Phone: $phone");
    print("Password: $password");
    print("Provider ID: $providerTypeId");
    print("Provider Key: $providerTypeKey");
    print("Provider Label: $providerTypeLabel");
    print("Profile Photo Instance: ${profilePhoto?.path.toString()}");
    print("Identification Photo Instance: ${photoForIdentification.toString()}");

    // ⭐ Now read service info
    serviceId = serviceCtrl.serviceId.value;
    serviceTitle = serviceCtrl.serviceTitle.value;
    servicePrice = serviceCtrl.servicePrice.value;

    print("===== SERVICE RECEIVED =====");
    print("Service ID: $serviceId");
    print("Service Title: $serviceTitle");
    print("Service Price: $servicePrice");
    print("Role: =========================== $role");


  }

  Future<void> loadRole() async {
    final r = await RoleController().getRole();
    role = r;

    print("================== ROLE LOADED ==================");
    print("Role from local storage: ${role?.name}");
    print("=================================================");
  }


  /// Image picker
  final ImagePicker _picker = ImagePicker();

  Future<void> registration() async {
    if (profilePhoto == null) {
      Get.snackbar("Error", "Please upload a profile photo first");
      return;
    }

    if (photoForIdentification.value == null) {
      Get.snackbar("Error", "Please upload an identification photo first");
      return;
    }

    isLoading.value = true;

    try {
      final api = ApiClient();

      // Prepare files
      List<MultipartFileData> files = [
        MultipartFileData(key: "profile_image", path: profilePhoto!.path),
        MultipartFileData(key: "identification_images", path: photoForIdentification.value!.path),
      ];

      Map<String, String> fields = {};

      if (providerTypeKey == "DOCTOR") {
        // Parse languages
        String languagesText = doctorController.languagesSpokenController.text.trim();
        List<String> languagesList = languagesText.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

        // Create a JSON object for complex data
        Map<String, dynamic> jsonData = {
          "fullName": name.trim(),
          "email": email.trim(),
          "phone": phone.trim(),
          "password": password,
          "role": role?.name ?? "PROVIDER",
          "providerTypeId": providerTypeId,
          "providerTypeString": providerTypeKey,
          "specialization": doctorController.specialisationsController.text.trim(),
          "identificationNumber": doctorController.medicalLicenseNumberController.text.trim(),
          "medicalLicenseNumber": doctorController.medicalLicenseNumberController.text.trim(),
          "serviceId": [serviceId], // Array
          "yearsOfExperience": int.tryParse(doctorController.yearOfExperienceController.text.trim()) ?? 0, // Number
          "languages": languagesList, // Array
          "address": doctorController.addressController.text.trim(),
          "about": doctorController.aboutController.text.trim(),
        };

        // Convert all fields to JSON string
        fields = {
          "data": jsonEncode(jsonData), // Send entire object as JSON
        };

      } else {
        Map<String, dynamic> jsonData = {
          "fullName": pharmacyController.nameController.text.trim(),
          "email": email.trim(),
          "phone": phone.trim(),
          "password": password,
          "role": role?.name ?? "PROVIDER",
          "providerTypeId": providerTypeId,
          "providerTypeString": providerTypeKey,
          "displayName": pharmacyController.nameController.text.trim(),
          "businessRegistrationNumber": name.trim(),
          "serviceId": [serviceId], // Array
          "drugLicenseNumber": pharmacyController.drugLicenseNumberController.text.trim(),
          "address": pharmacyController.addressController.text.trim(),
          "about": pharmacyController.aboutController.text.trim(),
        };

        fields = {
          "data": jsonEncode(jsonData),
        };
      }

      print('=== SENDING DATA ===');
      print('Fields: $fields');

      final res = await api.multipart(
        url: ApiUrl.userRegister,
        fields: fields,
        files: files,
      );

      isLoading.value = false;

      if (res.statusCode == 201 && res.body["success"] == true) {
        Get.snackbar("Success", res.body["message"] ?? "Registered successfully");
        Get.toNamed(RoutePath.verification);
      } else {
        Get.snackbar("Error", res.body["message"] ?? "Registration failed");
        print('Error details: ${res.body}');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
      print('Exception: $e');
    }
  }





}
