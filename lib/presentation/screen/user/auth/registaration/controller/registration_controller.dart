
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/role_controller/role_controller.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';


class RegistrationController extends GetxController {
  /// Text controllers
  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final membershipIDController = TextEditingController();
  final addressController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final identificationController = TextEditingController();



  /// Focus nodes
  final fullNameFocus = FocusNode();
  final dateOfBirthFocus = FocusNode();
  final genderFocus = FocusNode();
  final bloodGroupFocus = FocusNode();
  final membershipIDFocus = FocusNode();
  final addressFocus = FocusNode();
  final emergencyFocus = FocusNode();
  final identificationFocus = FocusNode();

  /// Form key for validation
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;


  /// Selection states
  final selectedBloodLabel = ''.obs;
  final selectedBloodCode = ''.obs;

  void setBloodGroup({required String label, required String code}) {
    selectedBloodLabel.value = label;
    selectedBloodCode.value = code;
    bloodGroupController.text = label; // reflect in field
  }




  @override
  void onClose() {
    // Dispose controllers & focus nodes to prevent memory leaks
    fullNameController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
    bloodGroupController.dispose();
    membershipIDController.dispose();
    addressController.dispose();
    emergencyContactController.dispose();
    identificationController.dispose();

    fullNameFocus.dispose();
    dateOfBirthFocus.dispose();
    genderFocus.dispose();
    bloodGroupFocus.dispose();
    membershipIDFocus.dispose();
    addressFocus.dispose();
    emergencyFocus.dispose();
    identificationFocus.dispose();
    super.onClose();
  }

}
