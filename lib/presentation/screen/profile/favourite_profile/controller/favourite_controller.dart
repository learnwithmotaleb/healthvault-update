import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../service/api_service.dart';
import '../model/favorite_model.dart';

class FavouriteController extends GetxController {
  var isLoading = true.obs;
  var favoriteList = <Data>[].obs;

  // ✅ Fast O(1) lookup Set — used by ALL screens to check favorite status
  var favoriteIds = <String>{}.obs;

  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  /// Fetch all favorites from API
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

          // ✅ Sync ID set from loaded list
          favoriteIds.value = model.data!
              .where((d) => d.providerId?.sId != null)
              .map((d) => d.providerId!.sId!)
              .toSet();
        } else {
          favoriteList.clear();
          favoriteIds.value = {};
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

  /// ✅ Check if a provider is favorited — use this in any screen
  bool isFavorite(String providerId) => favoriteIds.contains(providerId);

  /// ✅ Toggle by provider ID only — works from any screen
  Future<void> toggleFavorite(String providerId, {String? providerName}) async {
    if (isFavorite(providerId)) {
      await _removeFavorite(providerId, providerName: providerName);
    } else {
      await _addFavorite(providerId, providerName: providerName);
    }
  }

  /// Add favorite with optimistic update + rollback on failure
  Future<void> _addFavorite(String providerId, {String? providerName}) async {
    // ✅ Optimistic update — UI changes instantly
    // ✅ Reassign .value so Obx detects the change (not .add())
    favoriteIds.value = {...favoriteIds, providerId};

    try {
      final response = await apiClient.post(
        url: ApiUrl.createFavorite(providerId),
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Refresh full list to get complete Data object
        fetchFavorites();
        Get.snackbar('Success', '${providerName ?? 'Provider'} added to favorites');
      } else {
        // ✅ Rollback on failure
        favoriteIds.value = favoriteIds.where((id) => id != providerId).toSet();
        Get.snackbar('Error', response.body['message'] ?? 'Failed to add favorite');
      }
    } catch (e) {
      // ✅ Rollback on error
      favoriteIds.value = favoriteIds.where((id) => id != providerId).toSet();
      Get.snackbar('Error', 'Failed to add favorite: $e');
    }
  }

  /// Remove favorite with optimistic update + rollback on failure
  Future<void> _removeFavorite(String providerId, {String? providerName}) async {
    // ✅ Optimistic update
    favoriteIds.value = favoriteIds.where((id) => id != providerId).toSet();

    // Keep removed item in case we need to rollback
    final removedItem = favoriteList.firstWhereOrNull(
          (d) => d.providerId?.sId == providerId,
    );
    if (removedItem != null) {
      favoriteList.remove(removedItem);
    }

    try {
      final response = await apiClient.delete(
        url: ApiUrl.removeFavorite(providerId),
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar('Removed', '${providerName ?? 'Provider'} removed from favorites');
      } else {
        // ✅ Rollback on failure
        favoriteIds.value = {...favoriteIds, providerId};
        if (removedItem != null) favoriteList.add(removedItem);
        Get.snackbar('Error', response.body['message'] ?? 'Failed to remove favorite');
      }
    } catch (e) {
      // ✅ Rollback on error
      favoriteIds.value = {...favoriteIds, providerId};
      if (removedItem != null) favoriteList.add(removedItem);
      Get.snackbar('Error', 'Failed to remove favorite: $e');
    }
  }
}