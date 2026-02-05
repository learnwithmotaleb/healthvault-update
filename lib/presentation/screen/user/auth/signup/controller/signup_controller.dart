
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/helper/local_db/local_db.dart';
import 'package:healthvault/presentation/screen/user/auth/registaration/controller/registration_controller.dart';
import 'package:healthvault/service/api_service.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/role_controller/role_controller.dart';
import '../../../../../global_navigation_maneger/golobal_navigation_menegar.dart';
import '../../../../provider/doctor_identification/screen/doctor_identification_screen.dart';
import '../../../../provider/select_provider/controller/provider_selection_controller.dart';

class SignupController extends GetxController {


  RxString name = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString password = "".obs;




  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxString selectedProviderId = "".obs;
  RxString selectedProviderKey = "".obs;
  RxString selectedProviderLabel = "".obs;


  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      selectedProviderId.value = Get.arguments["id"] ?? "";
      selectedProviderKey.value = Get.arguments["key"] ?? "";
      selectedProviderLabel.value = Get.arguments["label"] ?? "";

      print("Provider ID: ${selectedProviderId.value}");
      print("Provider Key: ${selectedProviderKey.value}");
      print("Provider Label: ${selectedProviderLabel.value}");
    }
  }

  /// Call this after signup or when you want to navigate
  void navigateBasedOnProvider(String role) {
    final label = selectedProviderLabel.value.toLowerCase();

    if (label.startsWith("do")) {
      Get.toNamed(
        RoutePath.doctorIdentification,
        arguments: {
          "providerLabel": label,
          "role": role, // ⭐ SEND ROLE HERE
        },
      );
    } else {
      Get.toNamed(
        RoutePath.pharmacyIdentification,
        arguments: {
          "providerLabel": label,
          "role": role, // ⭐ SEND ROLE HERE
        },
      );
    }
  }



  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  Future<void> signup() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    // Save data globally so next screens can use it
    name.value = fullNameController.text.trim();
    email.value = emailController.text.trim();
    phone.value = phoneController.text.trim();
    password.value = passwordController.text.trim();

    // ------------------ Role-based Navigation ------------------
    final rawRole = await SharePrefsHelper.getRole();
    final role = (rawRole ?? "USER").toLowerCase();

    final roleController = Get.put(RoleController());
    final isProvider = await roleController.isProvider();

    if (role == "provider" || isProvider) {
      navigateBasedOnProvider(role); // ⭐ SEND ROLE
    } else {
      Get.toNamed(RoutePath.registration, arguments: {
        "role": role,
      });
    }

  }



  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
