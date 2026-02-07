import 'package:get/get.dart';

import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/model.dart';

class ProviderDetailsController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  var isLoading = false.obs;
  var appointment = Rxn<Data>(); // single appointment data

  Future<void> getAppointmentDetails(String appointmentId) async {
    try {
      isLoading.value = true;

      final response = await _apiClient.get(
        url: ApiUrl.providerAppointmentDetails(appointmentId),
        isToken: true,
      );

      if (response.statusCode == 200) {
        final model = AppointmentDetailsModel.fromJson(response.body);
        appointment.value = model.data;
      } else {
        Get.snackbar("Error", "Failed to load appointment");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}