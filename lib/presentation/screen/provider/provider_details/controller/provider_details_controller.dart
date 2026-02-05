import 'package:get/get.dart';

class ProviderDetailsController extends GetxController{


<<<<<<< Updated upstream
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
=======
>>>>>>> Stashed changes
}