import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/health_log_model.dart';

class HealthLogMyselfController extends GetxController {

  final familyMemberName = TextEditingController();
  final bloodPressure = TextEditingController();
  final heartRate = TextEditingController();
  final weight = TextEditingController();
  final bloodSugar = TextEditingController();

  final String forWhom = "SELF";

  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;
  RxList<Data> healthLogSelfList = <Data>[].obs;


  @override
  void onInit() {
    super.onInit();
    getHealthLogSelfList();
  }

  /// ===============================
  /// GET Health Log (SELF)
  /// ===============================
  /// ===============================
  /// GET Health Log (SELF)
  /// ===============================
  Future<void> getHealthLogSelfList() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.getHealthLogSelf,
        isToken: true,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonBody;

        // Ensure response.body is decoded JSON
        if (response.body is String) {
          jsonBody = response.body.isNotEmpty
              ? Map<String, dynamic>.from(jsonDecode(response.body))
              : {};
        } else {
          jsonBody = Map<String, dynamic>.from(response.body);
        }

        final model = HealthLogSelfModel.fromJson(jsonBody);

        if (model.success == true) {
          healthLogSelfList.assignAll(model.data ?? []);
          print("✅ Fetched health logs: ${healthLogSelfList.length}");
        } else {
          AppSnackBar.fail(model.message ?? "Something went wrong");
        }
      } else {
        AppSnackBar.fail("API Error: ${response.statusText}");
      }
    } catch (e) {
      AppSnackBar.fail("Network error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  /// ===============================
  /// ADD Health Log (SELF)
  /// ===============================
  Future<void> addHealthLog() async {
    if (familyMemberName.text.isEmpty ||
        bloodPressure.text.isEmpty ||
        heartRate.text.isEmpty ||
        weight.text.isEmpty ||
        bloodSugar.text.isEmpty) {
      AppSnackBar.fail("All fields are required");
      return;
    }

    try {
      isLoading.value = true;

      final fields = {
        "forWhom": forWhom,
        "familyMemberName": familyMemberName.text.trim(),
        "bloodPressure": bloodPressure.text.trim(),
        "heartRate": heartRate.text.trim(),
        "weight": double.tryParse(weight.text.trim()) ?? 0,
        "bloodSugar": bloodSugar.text.trim(),
      };

      final response = await apiClient.post(
        url: ApiUrl.postHealthLog,
        body: fields,
        customHeaders: {
          "Authorization": await SharePrefsHelper.getToken() ?? ""
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackBar.success("Health Log added successfully");

        clearForm();
        Get.back();
        await getHealthLogSelfList();
      } else {
        AppSnackBar.fail(response.statusText ?? "Failed");
      }
    } catch (e) {
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ===============================
  /// UPDATE Health Log (SELF)
  /// ===============================
  Future<void> updateHealthLog(String id) async {
    if (familyMemberName.text.isEmpty ||
        bloodPressure.text.isEmpty ||
        heartRate.text.isEmpty ||
        weight.text.isEmpty ||
        bloodSugar.text.isEmpty) {
      AppSnackBar.fail("All fields are required!");
      return;
    }

    try {
      isLoading.value = true;

      final fields = {
        "forWhom": forWhom,
        "familyMemberName": familyMemberName.text.trim(),
        "bloodPressure": bloodPressure.text.trim(),
        "heartRate": heartRate.text.trim(),
        "weight": double.tryParse(weight.text.trim()) ?? 0,
        "bloodSugar": bloodSugar.text.trim(),
      };


      final response = await apiClient.patch(
        url: ApiUrl.updateHealthLogMySelf(id),
        body: fields,
        isToken: true,
      );

      if (response.statusCode == 200) {
        AppSnackBar.success("Health Log updated successfully!");
        Get.back();
        await getHealthLogSelfList();
      } else {
        AppSnackBar.fail(response.body["message"] ?? "Update failed");
      }
    } catch (e) {
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ===============================
  /// DELETE Health Log
  /// ===============================
  Future<void> deleteHealthLog(String id) async {
    try {
      isLoading.value = true;

      final response = await apiClient.delete(
        url: ApiUrl.deleteHealthLog(id),
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        AppSnackBar.success("Health Log deleted successfully!");
        await getHealthLogSelfList();
      } else {
        AppSnackBar.fail(response.body["message"] ?? "Delete failed");
      }
    } catch (e) {
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear form
  void clearForm() {
    familyMemberName.clear();
    bloodPressure.clear();
    heartRate.clear();
    weight.clear();
    bloodSugar.clear();
  }

  /// Pull to refresh
  Future<void> refreshHealthLog() async {
    await getHealthLogSelfList();
  }
}
