import 'package:get/get.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import '../../../../../helper/local_db/shareprefs_helper.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../profile/profile/model/user_profile_model.dart';
import '../model/provider_appointment_model.dart';

class ProviderHomeController extends GetxController {
  var isLoading = true.obs;
  var appointments = <Appointment>[].obs;

  // ✅ Profile data
  var profileData = Rx<ProfileData?>(null);

  final ApiClient apiClient = ApiClient();

  // ✅ Helper getters
  String get fullName => profileData.value?.fullName ?? "";
  String get fullImageUrl {
    final raw = profileData.value?.profileImage ?? "";
    if (raw.isEmpty) return "";
    return raw
        .replaceAll('\\\\', '/')
        .replaceAll('\\', '/');
  }
  String get specialization => profileData.value?.specialization ?? "";
  String get providerType => profileData.value?.providerTypeId?.label ?? "";

  @override
  void onInit() {
    super.onInit();
    fetchProviderProfile(); // ✅ fetch profile on init
    fetchAppointments();
  }

  // ✅ Fetch provider profile
  Future<void> fetchProviderProfile() async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getProviderProfile, // "$baseUrl/user/getMe"
        isToken: true,
      );

      print("📦 Provider Profile Response: ${response.body}");

      if (response.statusCode == 200) {
        final body = response.body;

        if (body["success"] == true && body["data"] != null) {
          final data = body["data"];

          if (data is List && data.isNotEmpty) {
            final userMap = data[0] as Map<String, dynamic>;

            // ✅ Merge top-level + providerDetails[0]
            final details = (userMap["providerDetails"] as List?)
                ?.isNotEmpty == true
                ? userMap["providerDetails"][0] as Map<String, dynamic>
                : <String, dynamic>{};

            final merged = {
              ...userMap,
              ...details,
              "profile_image": details["profile_image"] ?? "",
            };

            profileData.value = ProfileData.fromJson(merged);

            print("✅ Provider: ${profileData.value?.fullName} | ${profileData.value?.specialization}");

          } else if (data is Map<String, dynamic>) {
            profileData.value = ProfileData.fromJson(data);
          }
        }
      } else {
        print("❌ Profile fetch failed: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ fetchProviderProfile error: $e");
    }
  }

  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.providerAppointment,
        isToken: true,
      );

      print("📥 API Response Status: ${response.statusCode}");
      print("📥 API Response Body: ${response.body}");

      if (response.statusCode == 200 && response.body['success'] == true) {
        final appointmentModel =
        ProviderAppointmentModel.fromJson(response.body);

        appointments.value = appointmentModel.data?.data ?? [];

        print("✅ Total Appointments: ${appointments.length}");
        for (final appointment in appointments) {
          print(
            "🩺 ${appointment.normalUserId?.fullName} | "
                "Service: ${appointment.serviceId?.title} | "
                "Status: ${appointment.status}",
          );
        }
      } else {
        AppSnackBar.fail(
            response.body['message'] ?? "Failed to fetch appointments");
        print("❌ API Error: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Refresh both
  Future<void> refresh() async {
    await Future.wait([
      fetchProviderProfile(),
      fetchAppointments(),
    ]);
  }
}