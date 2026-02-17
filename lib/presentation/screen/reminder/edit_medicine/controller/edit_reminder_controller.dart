import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/service/api_service.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_url.dart';
import '../../add_medicine/widget/convert_time.dart';

class EditReminderController extends GetxController {
  // Controllers for fields
  final pillNameController = TextEditingController();
  final dosageController = TextEditingController();
  final perDayController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final instructionsController = TextEditingController();
  final timeController = TextEditingController();
  final freequencyController = TextEditingController();
  final medicationController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Checkbox / selections
  final isChecked = false.obs;
  final selectedDosageLabel = ''.obs;
  final selectedDosageCode = ''.obs;
  final selectedPerDayLabel = ''.obs;
  final selectedPerDayCode = ''.obs;

  late String reminderId;

  // Loading
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    reminderId = args['id'];
  print("  //=================Reminder id======================");
    print(reminderId.toString());
  print("  //=================Reminder id======================");


  }

  /// Set selected dosage
  void setDosageServiceGroup({required String label, required String code}) {
    selectedDosageLabel.value = label;
    selectedDosageCode.value = code;
    dosageController.text = label;
  }

  /// Set selected per-day schedule
  void setPerDayServiceGroup({required String label, required String code}) {
    selectedPerDayLabel.value = label;
    selectedPerDayCode.value = code;
    perDayController.text = label;
  }

  /// Validate time in HH:MM format
  bool _isValidTimeFormat(String time) {
    final regex = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
    return regex.hasMatch(time);
  }

  /// Validate all fields before updating
  bool validateFields() {
    if (pillNameController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please enter pill name");
      return false;
    }
    if (dosageController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please select dosage");
      return false;
    }
    if (perDayController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please select times per day");
      return false;
    }
    if (timeController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please select time");
      return false;
    }

    if (freequencyController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please enter frequency");
      return false;
    }
    if (startDateController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please select start date");
      return false;
    }
    if (endDateController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please select end date");
      return false;
    }
    if (instructionsController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please enter instructions");
      return false;
    }
    if (medicationController.text.trim().isEmpty) {
      AppSnackBar.fail(title: "Reminder", "Please assign this medication");
      return false;
    }

    return true; // All validations passed
  }

  /// UPDATE Reminder API
  Future<void> updateReminder() async {
    if (!validateFields()) return;

    /// ✅ FORMAT TIME TO HH:MM
    String rawTime = timeController.text.trim();

    // যদি AM/PM থাকে তাহলে convert করো
    TimeOfDay? pickedTime;
    try {
      final parts = rawTime.split(":");
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1].substring(0, 2));

        pickedTime = TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}

    if (pickedTime == null) {
      AppSnackBar.fail(title: "Reminder", "Invalid time format");
      return;
    }

    final formattedTime =
        "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";

    final times = [formattedTime];

    /// ✅ FORMAT DATE TO ISO
    DateTime? startDate;
    DateTime? endDate;

    try {
      startDate = DateTime.parse(startDateController.text.trim());
      endDate = DateTime.parse(endDateController.text.trim());
    } catch (_) {
      AppSnackBar.fail(title: "Reminder", "Invalid date format");
      return;
    }

    final body = {
      "pillName": pillNameController.text.trim(),
      "dosage": int.tryParse(dosageController.text.trim()) ?? 0,
      "timesPerDay": int.tryParse(perDayController.text.trim()) ?? 1,
      "times": times,
      "schedule": freequencyController.text.trim(),
      "startDate": startDate.toUtc().toIso8601String(),
      "endDate": endDate.toUtc().toIso8601String(),
      "instructions": instructionsController.text.trim(),
      "assignedTo": medicationController.text.trim()
    };

    isLoading.value = true;

    try {
      final api = ApiClient();
      final url = ApiUrl.updateReminder(reminderId);

      final response = await api.patch(
        url: url,
        body: body,
        isToken: true,
      );

      if (response.statusCode == 200 &&
          response.body["success"] == true) {
        AppSnackBar.success(
            title: "Reminder", "Reminder Updated Successfully");
        Get.back();
      } else {
        AppSnackBar.info(
            title: "Reminder",
            response.body["message"] ?? "Update Failed");
      }
    } catch (e) {
      AppSnackBar.fail(title: "Reminder", "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {





    pillNameController.dispose();
    dosageController.dispose();
    perDayController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    instructionsController.dispose();
    timeController.dispose();
    freequencyController.dispose();
    medicationController.dispose();
    super.onClose();
  }
}
