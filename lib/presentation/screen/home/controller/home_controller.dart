import 'package:get/get.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../helper/local_db/local_db.dart';
import '../../../../helper/local_db/shareprefs_helper.dart';
import '../../health_and_wellness_article/model/article_model.dart';
import '../../profile/profile/model/user_profile_model.dart';
import '../model/get_all_provider.dart' hide ProviderType;
import '../model/get_all_provider_type_model.dart';

class HomeController extends GetxController {

  var isLoading = true.obs;

  var profileData = Rx<ProfileData?>(null);
  var jwtPayload = Rx<JwtPayload?>(null);

  var providerTypes = <ProviderType>[].obs;
  var articles = <Article>[].obs;
  var allProviders = <Provider>[].obs;

  final ApiClient apiClient = ApiClient();

  // ✅ Role from SharedPreferences
  String get savedRole => SharePrefsHelper.getRole()?.toUpperCase() ?? "";
  bool get isProvider => savedRole == "PROVIDER";
  bool get isNormalUser => savedRole == "NORMALUSER";

  // ✅ Profile helper getters
  String get fullName => profileData.value?.fullName ?? "";
  String get role => savedRole;
  String get fullImageUrl {
    final raw = profileData.value?.profileImage ?? "";
    return raw.isNotEmpty ? ApiUrl.buildImageUrl(raw) : "";
  }

  @override
  void onInit() {
    super.onInit();
    _printRoleInfo(); // ✅ print role on init
    fetchProviderTypes();
    fetchUserProfile();
    fetchArticles();
    fetchAllProviders();
  }

  // ✅ Print role and IDs from local storage
  void _printRoleInfo() {
    print("============================");
    print("👤 Role     : $savedRole");
    print("🔑 Token    : ${SharePrefsHelper.getToken()}");
    print("🆔 User ID  : ${SharePrefsHelper.getUserId()}");
    print("📋 Profile ID: ${SharePrefsHelper.getProfileId()}");
    print("============================");
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

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      final url = isProvider
          ? ApiUrl.getProviderProfile
          : ApiUrl.getUserProfile;

      final response = await apiClient.get(url: url, isToken: true);

      print("📦 Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final body = response.body;

        if (body["success"] == true && body["data"] != null) {
          final data = body["data"];

          if (data is List && data.isNotEmpty) {
            final userMap = data[0] as Map<String, dynamic>;

            if (isNormalUser) {
              // ✅ Merge top-level fields + normalUserDetails[0]
              final details = (userMap["normalUserDetails"] as List?)?.isNotEmpty == true
                  ? userMap["normalUserDetails"][0] as Map<String, dynamic>
                  : <String, dynamic>{};

              // ✅ Combine both maps — details override top-level
              final merged = {
                ...userMap,
                ...details,
                "profile_image": details["profile_image"] ?? "",
              };

              profileData.value = ProfileData.fromJson(merged);

            } else if (isProvider) {
              // ✅ Provider — same pattern with providerDetails if needed
              final details = (userMap["providerDetails"] as List?)?.isNotEmpty == true
                  ? userMap["providerDetails"][0] as Map<String, dynamic>
                  : <String, dynamic>{};

              final merged = {
                ...userMap,
                ...details,
                "profile_image": details["profile_image"] ?? "",
              };

              profileData.value = ProfileData.fromJson(merged);
            }

            _printProfileInfo();
          }
        } else {
          Get.snackbar('Info', body["message"] ?? 'No user data found');
        }
      } else {
        Get.snackbar('Error', response.statusText ?? 'Something went wrong');
      }
    } catch (e) {
      print("❌ fetchUserProfile error: $e");
      Get.snackbar('Error', 'Failed to fetch profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Print profile details based on role
  void _printProfileInfo() {
    final p = profileData.value;
    print("============================");
    print("📸 Name     : ${p?.fullName}");
    print("🖼  Image    : $fullImageUrl");
    print("📍 Address  : ${p?.address}");

    if (isProvider) {
      print("--- 🏥 PROVIDER INFO ---");
      print("🔬 Specialization : ${p?.specialization}");
      print("🏷  Provider Type  : ${p?.providerTypeId?.label}");
      print("📜 License        : ${p?.medicalLicenseNumber}");
      print("📅 Experience     : ${p?.yearsOfExperience} years");
      print("🗣  Languages      : ${p?.languages?.join(', ')}");
      print("✅ Verified       : ${p?.isVerified}");
    } else {
      print("--- 👤 USER INFO ---");
      print("🩸 Blood Group    : ${p?.bloodGroup}");
      print("⚧  Gender         : ${p?.gender}");
      print("🎂 Date of Birth  : ${p?.dateOfBirth}");
      print("🪪  Member ID      : ${p?.membershipId}");
      print("🆘 Emergency      : ${p?.emergencyContact}");
    }
    print("============================");
  }

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
}
