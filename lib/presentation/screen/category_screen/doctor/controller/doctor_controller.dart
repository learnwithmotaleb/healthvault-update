import 'package:get/get.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

class DoctorController extends GetxController {
  var isLoading = false.obs;
  var doctors = <Map<String, dynamic>>[].obs;

  final ApiClient apiClient;

  DoctorController({required this.apiClient});

  /// Fetch doctors by provider type id
  Future<void> fetchDoctors(String providerTypeId) async {
    isLoading.value = true;
    try {
      final response = await apiClient.get(
        url: ApiUrl.getProviderById(providerTypeId),
        isToken: true,
      );

      if (response.statusCode == 200) {
        final body = response.body;

        // Safely get the doctors list
        final List<dynamic>? doctorsList = (body['data']?['data']) as List<dynamic>?;

        if (doctorsList != null) {
          doctors.value = doctorsList
              .map((doctor) => doctor as Map<String, dynamic>)
              .toList();
        } else {
          doctors.value = [];
          print("Fetch doctors error: doctors list is null");
        }
      } else {
        doctors.value = [];
        print("Fetch doctors error: ${response.statusText}");
      }
    } catch (e) {
      print("Fetch doctors error: $e");
      doctors.value = [];
    } finally {
      isLoading.value = false;
    }
  }



}
