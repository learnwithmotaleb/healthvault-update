import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:healthvault/helper/local_db/local_db.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/model.dart';

class ProviderEditScheduleController extends GetxController {
  final startTime = TextEditingController();
  final endTime = TextEditingController();

  final isLoading = false.obs;

  /// provider availability list
  final availabilityList = <Data>[].obs;

  final selectedDay = "".obs;

  final ApiClient _apiClient = ApiClient();

  var profileId = SharePrefsHelper.getProfileId();

  @override
  void onInit() {
    getProviderAvailability(profileId!);
    print("Profile Id: $profileId");
    super.onInit();
  }

  /// ---------------- DELETE Availability Slot ----------------
  Future<void> deleteAvailabilitySlot({
    required String availabilityDayId,
    required String availabilitySlotId,
  }) async {
    final response = await _apiClient.delete(
      url: ApiUrl.deleteProviderAvailability,
      body: {
        "availabilityDayId": availabilityDayId,
        "availabilitySlotId": availabilitySlotId,
      },
      isToken: true,
    );

    if (response.statusCode == 200) {
      AppSnackBar.success("Slot deleted successfully");
      await getProviderAvailability(profileId!);
    } else {
      AppSnackBar.fail(response.statusText ?? "Delete failed");
    }
  }

  /// ---------------- GET Provider Availability ----------------
  Future<void> getProviderAvailability(String profileId) async {
    isLoading.value = true;

    final response = await _apiClient.get(
      url: ApiUrl.getProviderAvailability(profileId),
      isToken: true,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      final model = AvailabilityDayModel.fromJson(response.body);
      availabilityList.assignAll(model.data ?? []);
    } else {
      AppSnackBar.fail(response.statusText ?? "Failed to load schedule");
    }
  }

  /// ---------------- Create Availability Day ----------------
  Future<String?> createAvailabilityDay() async {
    final response = await _apiClient.post(
      url: ApiUrl.createAvailabilityDay,
      body: {"dayOfWeek": selectedDay.value},
      isToken: true,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      AppSnackBar.success("Day added successfully");
      return response.body["data"]["_id"];
    } else {
      AppSnackBar.fail(response.statusText ?? "Failed to add day");
      return null;
    }
  }

  /// ---------------- Create Availability Slot ----------------
  Future<void> createAvailabilitySlot(String availabilityDayId) async {
    final response = await _apiClient.post(
      url: ApiUrl.createAvailabilitySlot,
      body: {
        "availabilityDayId": availabilityDayId,
        "startTime": startTime.text,
        "endTime": endTime.text,
      },
      isToken: true,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      AppSnackBar.success("Schedule updated successfully");
      clearFields();
      Get.back();
    } else {
      AppSnackBar.fail(response.statusText ?? "Failed to create slot");
    }
  }

  /// ---------------- Combined Action ----------------
  Future<void> submitSchedule() async {
    if (selectedDay.isEmpty ||
        startTime.text.isEmpty ||
        endTime.text.isEmpty) {
      AppSnackBar.fail("All fields are required");
      return;
    }

    String? dayId;

    /// ✅ Check if selected day already exists — reuse its ID
    final existingDay = availabilityList.firstWhereOrNull(
          (day) => day.dayOfWeek == selectedDay.value,
    );

    if (existingDay != null) {
      /// Day already exists, no need to create
      dayId = existingDay.sId;
    } else {
      /// Day doesn't exist, create it first
      dayId = await createAvailabilityDay();
    }

    if (dayId != null) {
      await createAvailabilitySlot(dayId);
      await getProviderAvailability(profileId!);
    }
  }

  void clearFields() {
    startTime.clear();
    endTime.clear();
    selectedDay.value = "";
  }

  @override
  void onClose() {
    startTime.dispose();
    endTime.dispose();
    super.onClose();
  }
}