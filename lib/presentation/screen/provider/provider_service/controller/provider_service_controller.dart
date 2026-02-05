import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../model/model.dart';

class ProviderServiceController extends GetxController {

  var title = TextEditingController();
  var price = TextEditingController();
  var providerType; // ✅ Add this



  var isLoading = false.obs;
  var services = <Data>[].obs; // This will hold the fetched services

  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchMyServices();
  }

  void fetchMyServices() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.myCreateService, // your endpoint
        isToken: true, // assuming you need a token
      );

      if (response.statusCode == 200) {
        // Parse API response into model
        final model = MyServicesModel.fromJson(response.body);
        if (model.success == true && model.data != null) {
          services.value = model.data!;
        } else {
          services.clear();
        }
      } else {
        services.clear();
      }
    } catch (e) {
      print("Error fetching services: $e");
      services.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ CREATE Service
  Future<void> createService({
    required String title,
    required int price,
    required String providerType,
  }) async {
    try {
      isLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.createService, // "$baseUrl/service/create-service"
        body: {
          "title": title.toString(),
          "price": price.toInt(),
          "providerType": providerType.toUpperCase(),
        },
        isToken: true,
      );

      if (response.statusCode == 200) {
        AppSnackBar.success("Service created successfully!");
        // Optionally, fetch updated services list
        fetchMyServices();
      } else {
        AppSnackBar.fail("Failed to create service!");
      }
    } catch (e) {
      AppSnackBar.fail("Error creating service: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ UPDATE Service
  Future<void> updateService({
    required String serviceId,
    required String title,
    required int price,
  }) async {
    try {
      isLoading.value = true;

      final response = await apiClient.patch(
        url: ApiUrl.serviceUpdate(serviceId),
        body: {
          "title": title,
          "price": price,
        },
        isToken: true,
      );

      if (response.statusCode == 200) {
        AppSnackBar.success("Service updated successfully!");
        fetchMyServices(); // refresh list
      } else {
        AppSnackBar.fail("Failed to update service!");
      }
    } catch (e) {
      AppSnackBar.fail("Error updating service: $e");
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> deleteService(String serviceId) async {
    try {
      final response = await apiClient.delete(
        url: ApiUrl.serviceDelete(serviceId), // replace with your actual delete endpoint// send the ID of service to delete
        isToken: true,
      );

      if (response.statusCode == 200) {
        AppSnackBar.success("Service deleted successfully!");
        // Remove the deleted item from the list locally
        services.removeWhere((element) => element.sId == serviceId);
      } else {
        AppSnackBar.fail("Failed to delete service!");
      }
    } catch (e) {
      AppSnackBar.fail("Error deleting service: $e");
    }
  }
}
