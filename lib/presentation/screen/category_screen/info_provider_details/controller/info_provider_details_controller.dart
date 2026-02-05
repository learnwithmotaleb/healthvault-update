import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../helper/local_db/local_db.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/info_single_provider_model.dart';

class InfoProviderDetailsController extends GetxController {
  /// ---------------- Text Controllers ----------------
  final selectYourDateController = TextEditingController();
  final selectTimeController = TextEditingController();
  final reasonController = TextEditingController();
  final selectServiceController = TextEditingController(); // optional: if service dropdown

  /// ---------------- API Client ----------------
  final apiClient = ApiClient();

  /// ---------------- Observables ----------------
  var isLoading = false.obs;
  var provider = Rxn<Data>(); // single provider
  var errorMessage = ''.obs;

  /// ---------------- Form key ----------------
  final formKey = GlobalKey<FormState>();

  /// ---------------- Picked Image ----------------
  final Rx<File?> pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  /// ---------------- Pick image from gallery ----------------
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) pickedImage.value = File(image.path);
  }

  /// ---------------- Fetch Provider Details ----------------
  Future<void> getProviderDetails(String profileId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiClient.get(
        url: ApiUrl.getSingleProviderById(profileId),
        isToken: true,
      );

      if (response.statusCode == 200 && response.body != null) {
        final model = InfoProviderModel.fromJson(response.body);
        provider.value = model.data;
      } else {
        errorMessage.value = response.statusText ?? "Failed to load provider";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// ---------------- Build Appointment DateTime in UTC ----------------
  String buildAppointmentDateTimeUtc() {
    final dateText = selectYourDateController.text.trim();
    final timeText = selectTimeController.text.trim();

    if (dateText.isEmpty || timeText.isEmpty) {
      throw Exception("Date or Time missing");
    }

    // Parse date safely
    final date = DateFormat('yyyy-MM-dd').parse(dateText);

    // Parse time safely
    final time = TimeOfDay.fromDateTime(DateFormat('hh:mm a').parse(timeText));

    final localDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return localDateTime.toUtc().toIso8601String();
  }

  /// ---------------- Create Appointment ----------------
  Future<void> createAppointment({
    required String providerId,
    required String serviceId,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final appointmentDateTime = buildAppointmentDateTimeUtc();

      final fields = {
        "providerId": providerId,
        "reasonForVisit": reasonController.text.trim(),
        "serviceId": serviceId,
        "appointmentDateTime": appointmentDateTime,
      };

      final List<MultipartFileData> files = [];
      if (pickedImage.value != null) {
        files.add(
          MultipartFileData(
            key: "appointment_images",
            path: pickedImage.value!.path,
          ),
        );
      }

      final response = await apiClient.multipart(
        url: ApiUrl.createAppointment,
        fields: fields,
        files: files,
        customHeaders: {
          "Authorization": await SharePrefsHelper.getToken() ?? "",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackBar.success("Appointment created successfully");
        Get.back();
      } else {
        AppSnackBar.fail(title: "Error", "Failed to create appointment");
      }
    } catch (e) {
      AppSnackBar.fail(title: "Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// ---------------- Dispose ----------------
  @override
  void onClose() {
    selectYourDateController.dispose();
    selectTimeController.dispose();
    reasonController.dispose();
    selectServiceController.dispose();
    super.onClose();
  }
}
