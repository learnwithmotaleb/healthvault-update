import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/service/api_service.dart';
import '../../../../../core/routes/route_path.dart';
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
    _loadArguments();
  }

  /// ✅ Pre-fill all fields from passed arguments
  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    reminderId = args['id']?.toString() ?? '';

    print("//=================Reminder id======================");
    print(reminderId);
    print("//=================Reminder id======================");

    // Pre-fill text controllers
    pillNameController.text = args['pillName']?.toString() ?? '';
    dosageController.text = args['dosage']?.toString() ?? '';
    perDayController.text = args['timesPerDay']?.toString() ?? '';
    freequencyController.text = args['schedule']?.toString() ?? '';
    instructionsController.text = args['instructions']?.toString() ?? '';
    medicationController.text = args['assignedTo']?.toString() ?? '';

    // ✅ Start / End date — store raw ISO for API, display formatted
    startDateController.text = args['startDate']?.toString() ?? '';
    endDateController.text = args['endDate']?.toString() ?? '';

    // ✅ Times — take first time if list exists
    final times = args['times'];
    if (times is List && times.isNotEmpty) {
      timeController.text = times.first.toString();
    }

    // ✅ Sync observable labels so dropdowns show correct selection
    selectedDosageLabel.value = dosageController.text;
    selectedDosageCode.value = dosageController.text;
    selectedPerDayLabel.value = perDayController.text;
    selectedPerDayCode.value = perDayController.text;
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
    return true;
  }

  /// UPDATE Reminder API
  Future<void> updateReminder() async {
    if (!validateFields()) return;

    // Format time to HH:MM
    String rawTime = timeController.text.trim();
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

    // Format dates to ISO
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
      "times": [formattedTime],
      "schedule": freequencyController.text.trim(),
      "startDate": startDate.toUtc().toIso8601String(),
      "endDate": endDate.toUtc().toIso8601String(),
      "instructions": instructionsController.text.trim(),
      "assignedTo": medicationController.text.trim(),
    };

    isLoading.value = true;

    try {
      final api = ApiClient();
      final response = await api.patch(
        url: ApiUrl.updateReminder(reminderId),
        body: body,
        isToken: true,
      );

      final isSuccess = (response.body["success"] as bool?) ?? false;

      if ((response.statusCode == 200 || response.statusCode == 201) && isSuccess) {
        isLoading.value = false;
        AppSnackBar.success(title: "Reminder", "Reminder Updated Successfully");
        Get.until((route) => route.settings.name == RoutePath.bottomNav);

      } else {
        isLoading.value = false;
        AppSnackBar.fail(title: "Reminder", response.body["message"] ?? "Update Failed");
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