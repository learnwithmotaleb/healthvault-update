import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/get_all_provider_model.dart';

class SearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();

  /// Original provider data from API
  final RxList<Data> providerList = <Data>[].obs;

  /// Filtered providers based on search
  final RxList<Data> filteredList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProviders();

    /// Listen search input
    searchTextController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchTextController.text.trim().toLowerCase();

    if (query.isEmpty) {
      filteredList.assignAll(providerList);
    } else {
      filteredList.assignAll(
        providerList.where((provider) {
          final name = provider.fullName?.toLowerCase() ?? '';
          final type = provider.providerType?.label?.toLowerCase() ?? '';
          final services = provider.services
              ?.map((s) => s.title?.toLowerCase() ?? '')
              .join(' ') ??
              '';
          final address = provider.address?.toLowerCase() ?? '';
          // Check all fields for query match
          return name.contains(query) ||
              type.contains(query) ||
              services.contains(query) ||
              address.contains(query);
        }).toList(),
      );
    }
  }

  void clearSearch() {
    searchTextController.clear();
    filteredList.assignAll(providerList);
  }

  /// Fetch all providers from API
  Future<void> fetchProviders() async {
    final apiClient = ApiClient();
    final response = await apiClient.get(
      url: ApiUrl.getAllProvider,
      isToken: true,
    );

    if (response.statusCode == 200) {
      final model = AllProviderModel.fromJson(response.body);
      if (model.success == true && model.data != null && model.data!.data != null) {
        providerList.assignAll(model.data!.data!);
        filteredList.assignAll(providerList);
      } else {
        Get.snackbar("Error", model.message ?? "Failed to fetch providers");
      }
    } else {
      Get.snackbar("Error", response.statusText ?? "Something went wrong");
    }
  }

  final ApiClient apiClient = ApiClient();

  /// Add a provider to favorite
  Future<bool> addFavorite(String providerId) async {
    final url = ApiUrl.createFavorite(providerId);

    final response = await apiClient.post(
      url: url,
      isToken: true, // assuming user must be logged in
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Success", "Added to favorites");
      return true;
    } else {
      Get.snackbar("Error", response.body['message'] ?? "Failed to add favorite");
      return false;
    }
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
