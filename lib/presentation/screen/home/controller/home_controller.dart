import 'package:get/get.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';


import '../../../../helper/local_db/local_db.dart';
import '../../health_and_wellness_article/model/article_model.dart';
import '../../profile/profile/model/user_profile_model.dart';
import '../model/get_all_provider.dart' hide ProviderType;
import '../model/get_all_provider_type_model.dart';

class HomeController extends GetxController {


  var isLoading = true.obs;
  var userData = Rx<Data?>(null); // user info
  var providerTypes = <ProviderType>[].obs;
  var articles = <Article>[].obs; // articles list
  var allProviders = <Provider>[].obs;



  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchProviderTypes();
    fetchUserProfile();
    fetchArticles();
    fetchAllProviders();
  }


  Future<void> fetchAllProviders() async {
    try {
      isLoading.value = true;

      final res = await apiClient.get(
        url: ApiUrl.getAllProvider,
        isToken: true,
      );

      if (res.statusCode == 200) {
        final model = GetAllProvidersModel.fromJson(res.body);
        if (model.success == true && model.data != null) {
          allProviders.assignAll(model.data!.data ?? []);
        } else {
          Get.snackbar('Info', model.message ?? 'No providers found');
        }
      } else {
        Get.snackbar('Error', res.statusText ?? 'Failed to load providers');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProviderTypes() async {
    try {
      isLoading.value = true;

      final res = await apiClient.get(
        url: ApiUrl.providerType,
        isToken: true,
      );

      if (res.statusCode == 200) {
        final model = ProviderTypeModel.fromJson(res.body);

        if (model.success == true) {
          providerTypes.assignAll(model.data);
        } else {
          Get.snackbar('Info', model.message);
        }
      } else {
        Get.snackbar('Error', res.statusText ?? 'Failed to load provider types');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch user profile
  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final response = await apiClient.get(url: ApiUrl.getUserProfile, isToken: true);

      if (response.statusCode == 200) {
        final model = UserProfile.fromJson(response.body);
        if (model.success == true && model.data != null && model.data!.isNotEmpty) {
          userData.value = model.data![0];
        } else {
          Get.snackbar('Info', model.message ?? 'No user data found');
        }
      } else {
        Get.snackbar('Error', response.statusText ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch articles for home screen
  Future<void> fetchArticles() async {
    try {
      final res = await apiClient.get(
        url: "${ApiUrl.getAllArticle}?page=1&limit=10",
        isToken: true,
      );

      if (res.statusCode == 200) {
        final model = GetAllArticleModel.fromJson(res.body);
        articles.assignAll(model.data?.articles ?? []);
      } else {
        Get.snackbar('Error', res.statusText ?? 'Failed to load articles');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
    }
  }


  /// Add a provider to favorite
  Future<bool> addFavorite(String providerId) async {
    final url = ApiUrl.createFavorite(providerId);

    final response = await apiClient.post(
      url: url,
      isToken: true, // assuming user must be logged in
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
     // await SharePrefsHelper.addFavoriteProvider(providerId);
      Get.snackbar("Success", "Added to favorites");
      return true;
    } else {
      Get.snackbar("Error", response.body['message'] ?? "Failed to add favorite");
      return false;
    }
  }


}
