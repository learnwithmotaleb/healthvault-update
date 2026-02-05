import 'package:get/get.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import 'package:healthvault/service/api_url.dart';
import 'package:healthvault/service/api_service.dart';

import '../model/my_appointment_model.dart' as appointment_model;

class AppointmentController extends GetxController {
  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;
  RxList<appointment_model.Data> appointments = <appointment_model.Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyAppointments();
  }

  /// ================================
  ///     GET My Appointments API
  /// ================================
  Future<void> getMyAppointments() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.myAppointment,
        isBasic: true,
        isToken: true, // token header added
      );

      if (response.statusCode == 200) {
        try {
          final model =
          appointment_model.MyAppoinmentModel.fromJson(response.body);

          if (model.success == true) {
            appointments.assignAll(model.data ?? []);
          } else {
            AppSnackBar.fail(model.message ?? "Something went wrong");
          }
        } catch (e) {
          AppSnackBar.fail("Parsing error: $e");
        }
      } else {
        AppSnackBar.fail("API Error: ${response.statusText}");
      }
    } catch (e) {
      AppSnackBar.fail("Network error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ================================
  ///     Pull to Refresh Function
  /// ================================
  Future<void> refreshAppointments() async {
    await getMyAppointments();
  }
}
