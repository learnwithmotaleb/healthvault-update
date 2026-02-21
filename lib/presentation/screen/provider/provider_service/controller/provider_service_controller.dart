import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../model/model.dart';

class ProviderServiceController extends GetxController {

  var title = TextEditingController();
  var price = TextEditingController();

  var providerType = ''.obs;
  var isLoading = false.obs;

  // ✅ Added for RefreshIndicator (pull-to-refresh)
  var isRefreshing = false.obs;

  var services = <Data>[].obs;

  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchMyServices();
  }

  void fetchMyServices() async {
    try {
      isLoading.value = true;
      await _loadServices();
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Pull-to-refresh method — called by RefreshIndicator
  Future<void> refreshServices() async {
    try {
      isRefreshing.value = true;
      await _loadServices();
    } finally {
      isRefreshing.value = false;
    }
  }

  // ✅ Shared core fetch logic used by both fetchMyServices & refreshServices
  Future<void> _loadServices() async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.myCreateService,
        isToken: true,
      );

      if (response.statusCode == 200) {
        final model = MyServicesModel.fromJson(response.body);
        if (model.success == true && model.data != null) {

          services.value = model.data!
              .where((service) => service.isDeleted == false)
              .toList();

          if (services.isNotEmpty) {
            providerType.value = services.first.providerType ?? '';
          }

        } else {
          services.clear();
        }
      } else {
        services.clear();
      }
    } catch (e) {
      print("Error fetching services: $e");
      services.clear();
    }
  }

  Future<void> createService({
    required String title,
    required int price,
    required String providerType,
  }) async {
    try {
      isLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.createService,
        body: {
          "title": title.toString(),
          "price": price.toInt(),
          "providerType": providerType.toUpperCase(),
        },
        isToken: true,
      );

      // ✅ Handle both 200 and 201 (Created)
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackBar.success("Service created successfully!");
        await _loadServices();
      } else {
        // ✅ Show actual server error message if available
        final message = response.body['message'] ?? "Failed to create service!";
        AppSnackBar.fail(message);
      }
    } catch (e) {
      AppSnackBar.fail("Error creating service: $e");
    } finally {
      isLoading.value = false;
    }
  }

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
        await _loadServices(); // ✅ refresh after update
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
        url: ApiUrl.serviceDelete(serviceId),
        isToken: true,
      );

      if (response.statusCode == 200) {
        AppSnackBar.success("Service deleted successfully!");
        // ✅ Remove locally for instant UI update, no need to refetch
        services.removeWhere((element) => element.sId == serviceId);
      } else {
        AppSnackBar.fail("Failed to delete service!");
      }
    } catch (e) {
      AppSnackBar.fail("Error deleting service: $e");
    }
  }
}