import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../widget/convert_time.dart';

class AddReminderController extends GetxController {
  // Controllers for fields
  final pillNameController = TextEditingController();
  final dosageController = TextEditingController();
  final perDayController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final instructionsController = TextEditingController();
  final freequencyController = TextEditingController();
  final medicationController = TextEditingController();

  // List of time controllers for multiple times
  final RxList<TextEditingController> timeControllers = <TextEditingController>[].obs;

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  // Checkbox / selection states
  final isChecked = false.obs;
  final selectedDosageLabel = ''.obs;
  final selectedDosageCode = ''.obs;
  final selectedPerDayLabel = ''.obs;
  final selectedPerDayCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Start with one time field
    addTimeField();
  }

  /// Add new TimePickerField dynamically
  void addTimeField() {
    timeControllers.add(TextEditingController());
  }

  /// Remove TimePickerField
  void removeTimeField(int index) {
    if (timeControllers.length > 1) {
      timeControllers[index].dispose();
      timeControllers.removeAt(index);
    } else {
      AppSnackBar.fail( title: "Health Vault", "At least one time is required");
    }
  }

  /// Set selected dosage
  void setDosageServiceGroup({required String label, required String code}) {
    selectedDosageLabel.value = label;
    selectedDosageCode.value = code;
    dosageController.text = label; // reflect in field
  }

  /// Set selected per-day schedule
  void setPerDayServiceGroup({required String label, required String code}) {
    selectedPerDayLabel.value = label;
    selectedPerDayCode.value = code;
    perDayController.text = label; // reflect in field
  }

  /// Validate HH:MM format
  bool _isValidTimeFormat(String time) {
    final regex = RegExp(r'^[0-2][0-9]:[0-5][0-9]$');
    return regex.hasMatch(time);
  }



  /// Add reminder API call
  Future<void> addReminder() async {
    if (!formKey.currentState!.validate()) return;

   // // Validate times
   //  for (var controller in timeControllers) {
   //    if (!_isValidTimeFormat(controller.text.trim())) {
   //      AppSnackBar.fail("Invalid time format: ${controller.text.trim()} (HH:MM)");
   //      return;
   //    }
   //  }




    final convertedTime = convertTimes(timeControllers.map((c) => c.text).toList());
    //===============================Time covert========
    print(convertedTime);
    //===============================Time covert========




    isLoading.value = true;

    try {
      final api = ApiClient();

      final res = await api.post(
        url: ApiUrl.createReminder,
        isToken: true,
          body: {
            "pillName": pillNameController.text.trim(),
            "dosage": int.tryParse(dosageController.text.trim()) ?? 0,  // FIXED
            "timesPerDay": int.tryParse(perDayController.text.trim()) ?? 1,
            "times":convertedTime,
            "schedule": freequencyController.text.trim(),
            "startDate": startDateController.text.trim(),
            "endDate": endDateController.text.trim(),
            "instructions": instructionsController.text.trim(),
            "assignedTo": medicationController.text.trim(),
            "scheduleMeta": {
              "dayOfWeek": 1,  // static for now
            },
          }

      );

      isLoading.value = false;

      if (res.statusCode == 200 && res.body["success"] == true) {
        AppSnackBar.success(title: "Health Vault","Reminder added successfully!");
        Get.toNamed(RoutePath.bottomNav);
      } else {
        AppSnackBar.fail(title: "Health Vault", res.body["message"] ?? "Failed to add reminder");
      }
    } catch (e) {
      isLoading.value = false;
      AppSnackBar.fail(title: "Reminder", "Error: $e");
      print("Error adding reminder: $e");
    }
  }

  @override
  void onClose() {
    // Dispose all text controllers to prevent memory leaks
    pillNameController.dispose();
    dosageController.dispose();
    perDayController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    instructionsController.dispose();
    freequencyController.dispose();
    medicationController.dispose();

    for (var controller in timeControllers) {
      controller.dispose();
    }

    super.onClose();
  }
}
