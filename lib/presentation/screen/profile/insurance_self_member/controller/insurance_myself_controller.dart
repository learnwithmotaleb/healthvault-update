import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/screen/profile/insurance_self_member/model/my_self_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../appointment/model/my_appointment_model.dart' hide Data;


class InsuranceMyselfController extends GetxController{

  final name = TextEditingController();
  final number = TextEditingController();
  final provider = TextEditingController();
  final expirationDate = TextEditingController();

  Rx<File?> insurancePhoto = Rx<File?>(null); // reactive File

  final forWhom = "SELF";



  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;
  RxList<Data> insuranceSelfList = <Data>[].obs;



  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery or camera
  Future<void> pickInsurancePhoto({bool fromCamera = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 70,
      );
      if (pickedFile != null) {
        insurancePhoto.value = File(pickedFile.path); // store picked file
      }
    } catch (e) {
      AppSnackBar.fail("Failed to pick image: $e");
    }
  }



  @override
  void onInit() {
    super.onInit();
    getInsuranceSelfList();
  }

  /// =====================================
  ///        GET All Insurance API
  /// =====================================
  Future<void> getInsuranceSelfList() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.getInsuranceSelf,
        isToken: true,
      );

      if (response.statusCode == 200) {
        try {
          final model = InsuranceSelfModel.fromJson(response.body);

          if (model.success == true) {
            insuranceSelfList.assignAll(model.data ?? []);
          } else {
            AppSnackBar.fail(model.message ?? "Something went wrong");
          }
        } catch (e) {
          AppSnackBar.fail("Parsing error: $e");
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


  /// POST Insurance API
  Future<void> addInsurance() async {
    if (insurancePhoto.value == null) {
      AppSnackBar.fail("Please upload an insurance photo.");
      return;
    }
    if (name.text.isEmpty ||
        number.text.isEmpty ||
        provider.text.isEmpty ||
        expirationDate.text.isEmpty) {
      AppSnackBar.fail("All fields are required!");
      return;
    }

    try {
      isLoading.value = true;

      final fields = {
        "forWhom": forWhom.toUpperCase(),
        "name": name.text,
        "number": number.text,
        "insuranceProvider": provider.text,
        "expiryDate": expirationDate.text,
      };

      final response = await apiClient.multipart(
        url: ApiUrl.postInsurance,
        fields: fields,
        files: insurancePhoto.value != null
            ? [
          MultipartFileData(
            key: "insurance_Photo",
            path: insurancePhoto.value!.path,
          )
        ]
            : [],
        isBasic: false,
        customHeaders: {"Authorization": await SharePrefsHelper.getToken() ?? ""},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackBar.success("Insurance added successfully!");
        // Clear form
        name.clear();
        number.clear();
        provider.clear();
        expirationDate.clear();
        insurancePhoto.value = null;
        Get.back();

        await getInsuranceSelfList(); // Refresh list
      } else {
        AppSnackBar.fail("API Error: ${response.statusText}");
      }
    } catch (e) {
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> updateInsurance(String id) async {
    if (name.text.isEmpty ||
        number.text.isEmpty ||
        provider.text.isEmpty ||
        expirationDate.text.isEmpty) {
      AppSnackBar.fail("All fields are required!");
      return;
    }

    try {
      isLoading.value = true;

      final fields = {
        "forWhom": forWhom, // SELF
        "name": name.text,
        "number": number.text,
        "insuranceProvider": provider.text,
        "expiryDate": expirationDate.text,
      };

      final response = await apiClient.patchWithMultipart(
        url: ApiUrl.updateInsuranceMySelf(id), // ✅ correct
        fields: fields,
        imageFile: insurancePhoto.value,
        isToken: true,
      );

      if (response.statusCode == 200) {
        AppSnackBar.success("Insurance updated successfully!");
        insurancePhoto.value = null;
        Get.back();
        await getInsuranceSelfList();
      } else {
        AppSnackBar.fail(response.body["message"] ?? "Update failed");
      }
    } catch (e) {
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }




  /// DELETE Insurance API
  Future<void> deleteInsurance(String id) async {
    try {
      isLoading.value = true;

      final response = await apiClient.delete(
        url: ApiUrl.deleteInsurance(id),
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        AppSnackBar.success("Insurance deleted successfully!");
        await getInsuranceSelfList(); // refresh list
      } else {
        AppSnackBar.fail(response.body["message"] ?? "Delete failed");
      }
    } catch (e) {
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }








  /// =====================================
  ///        Pull to Refresh
  /// =====================================
  Future<void> refreshInsurance() async {
    await getInsuranceSelfList();
  }


}