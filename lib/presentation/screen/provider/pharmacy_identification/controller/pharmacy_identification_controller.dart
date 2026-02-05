import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PharmacyIdentificationController extends GetxController{

  /// Text controllers
  final nameController = TextEditingController();
  final businessRegisterNumberController = TextEditingController();
  final pharmacyServiceController = TextEditingController();
  final drugLicenseNumberController = TextEditingController();
  final addressController = TextEditingController();
  final aboutController = TextEditingController();


  /// Form key for validation
  final formKey = GlobalKey<FormState>();

  /// Selection states
  final selectedPharmacyServiceLabel = ''.obs;
  final selectedPharmacyServiceCode = ''.obs;

  void setPharmacyServiceGroup({required String label, required String code}) {
    selectedPharmacyServiceLabel.value = label;
    selectedPharmacyServiceCode.value = code;
    pharmacyServiceController.text = label; // reflect in field
  }

  /// Registration action
  void registration() {
    // final isValid = formKey.currentState?.validate() ?? false;
    // if (!isValid) return;
    // // Proceed only if blood group is selected (optional extra guard)
    // if (selectedBloodCode.value.isEmpty) return;

    //Get.toNamed(RoutePath.identification);
  }

  @override
  void onClose() {
    // Dispose controllers & focus nodes to prevent memory leaks
    nameController.dispose();
    businessRegisterNumberController.dispose();
    pharmacyServiceController.dispose();
    drugLicenseNumberController.dispose();
    addressController.dispose();
    aboutController.dispose();
    super.onClose();
  }


}