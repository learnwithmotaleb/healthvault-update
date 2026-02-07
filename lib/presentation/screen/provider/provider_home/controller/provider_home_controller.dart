import 'package:get/get.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/provider_appointment_model.dart';

class ProviderHomeController extends GetxController {
  var isLoading = true.obs;
  var appointments = <Appointment>[].obs;

  final ApiClient apiClient = ApiClient(); // Use your ApiClient

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.providerAppointment,
        isToken: true, // automatically adds Authorization token
      );

      print("📥 API Response Status: ${response.statusCode}");
      print("📥 API Response Body: ${response.body}");

      if (response.statusCode == 200 && response.body['success'] == true) {
        // Parse response into model
        final appointmentModel = ProviderAppointmentModel.fromJson(response.body);

        // Assign typed appointments
        appointments.value = appointmentModel.data?.data ?? [];

        print("✅ Total Appointments: ${appointments.length}");
        appointments.forEach((appointment) {
          print(
              "🩺 ${appointment.normalUserId?.fullName} | "
                  "Service: ${appointment.serviceId?.title} | "
                  "Status: ${appointment.status}"
          );
        });

        AppSnackBar.success(appointmentModel.message ?? "Appointments fetched successfully");
      } else {
        AppSnackBar.fail(response.body['message'] ?? "Failed to fetch appointments");
        print("❌ API Error: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      AppSnackBar.fail("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}