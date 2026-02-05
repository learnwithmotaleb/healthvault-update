import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../service/api_service.dart';
import '../model/favorite_model.dart';

class FavouriteController extends GetxController {
  var isLoading = true.obs;
  var favoriteList = <Data>[].obs; // List of Data objects from FavoriteModel

  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  /// Fetch all favorite providers
  void fetchFavorites() async {
    try {
      isLoading.value = true;
      final response = await apiClient.get(
        url: ApiUrl.getAllFavorite,
        isToken: true,
      );

      if (response.statusCode == 200) {
        final model = FavoriteModel.fromJson(response.body);
        if (model.success == true && model.data != null) {
          favoriteList.value = model.data!;
        } else {
          favoriteList.clear();
          Get.snackbar('Info', model.message ?? 'No favorites found');
        }
      } else {
        Get.snackbar('Error', response.statusText ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Add a provider to favorites
  Future<void> addFavorite(String providerId, Data data) async {
    try {
      final response = await apiClient.post(
        url: ApiUrl.createFavorite(providerId),
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        favoriteList.add(data);
        Get.snackbar('Success', '${data.providerId!.fullName} added to favorites');
      } else {
        Get.snackbar('Error', response.body['message'] ?? 'Failed to add favorite');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add favorite: $e');
    }
  }

  /// Remove a provider from favorites
  Future<void> removeFavorite(String providerId, Data data) async {
    try {
      final response = await apiClient.delete(
        url: ApiUrl.removeFavorite(providerId),
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        favoriteList.remove(data);
        Get.snackbar('Removed', '${data.providerId!.fullName} removed from favorites');
      } else {
        Get.snackbar('Error', response.body['message'] ?? 'Failed to remove favorite');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove favorite: $e');
    }
  }

  /// Optional: Toggle favorite for UI convenience
  void toggleFavorite(Data data) {
    if (favoriteList.contains(data)) {
      removeFavorite(data.providerId!.sId!, data);
    } else {
      addFavorite(data.providerId!.sId!, data);
    }
  }
}
