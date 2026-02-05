import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';

import '../../../../../service/api_url.dart';
import '../model/provider_service_type_model.dart';

class ProviderSelectionController extends GetxController {
  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;
  RxList<Data> providerTypes = <Data>[].obs;

  /// Selected index for UI
  RxInt selectedIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    fetchProviderTypes();
  }

  /// Fetch provider types from API
  Future<void> fetchProviderTypes() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.providerType,
        isToken: true,
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = ProviderServiceType.fromJson(response.body);

        if (model.data != null && model.data!.isNotEmpty) {
          providerTypes.assignAll(model.data!);
        } else {
          AppSnackBar.info("No provider types available.");
        }
      } else {
        AppSnackBar.fail(response.body['message'] ?? "Failed to fetch provider types");
      }
    } catch (e) {
      AppSnackBar.fail("Error fetching provider types: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void navigateWithSelectedProvider() {
    if (selectedIndex.value >= 0 && selectedIndex.value < providerTypes.length) {
      final selectedProvider = providerTypes[selectedIndex.value];

      // Navigate to Signup and pass the selected provider
      Get.toNamed(
        RoutePath.signup,
        arguments: {
          "id": selectedProvider.sId ?? "",
          "key": selectedProvider.key ?? "",
          "label": selectedProvider.label ?? "",
        },
      );
    } else {
      AppSnackBar.info("Please select a provider type");
    }
  }


  /// Set selected index
  void selectProvider(int index) {
    selectedIndex.value = index;

    navigateWithSelectedProvider();
   // Get.toNamed(RoutePath.signup); // change route if needed
  }
}
