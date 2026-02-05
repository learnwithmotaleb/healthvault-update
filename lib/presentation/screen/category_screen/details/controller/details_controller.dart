import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  /// ---------------- Text controllers ----------------
  final reasonController = TextEditingController();
  final selectServiceController = TextEditingController();
  final selectYourDateController = TextEditingController();
  final selectTimeController = TextEditingController();

  /// ---------------- Form key ----------------
  final formKey = GlobalKey<FormState>();

  /// ---------------- Selection states ----------------
  final selectedServiceLabel = ''.obs;
  final selectedServiceCode = ''.obs;

  void setServiceGroup({required String label, required String code}) {
    selectedServiceLabel.value = label;
    selectedServiceCode.value = code;
    selectServiceController.text = label; // reflect in field
  }

  final isChecked = false.obs;

  /// ---------------- Received Data ----------------
  late Map<String, dynamic> normalUser;
  late Map<String, dynamic> provider;
  late Map<String, dynamic> service;
  late Map<String, dynamic> appointment;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    // Convert nested objects to Map
    normalUser = args['normalUser'] is Map
        ? args['normalUser']
        : (args['normalUser']?.toJson() ?? {}); // If it's a class, use toJson()

    provider = args['provider'] is Map
        ? args['provider']
        : (args['provider']?.toJson() ?? {});

    service = args['service'] is Map
        ? args['service']
        : (args['service']?.toJson() ?? {});

    appointment = args['appointment'] is Map
        ? args['appointment']
        : (args['appointment']?.toJson() ?? {});

    // Pre-fill some fields
    selectServiceController.text = service['title'] ?? '';
    selectYourDateController.text = appointment['appointmentDateTime'] ?? '';
  }


  @override
  void onClose() {
    reasonController.dispose();
    selectServiceController.dispose();
    selectYourDateController.dispose();
    selectTimeController.dispose();
    super.onClose();
  }
}
