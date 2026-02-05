import 'package:get/get.dart';

class ProviderProfileController extends GetxController{




<<<<<<< Updated upstream
  Future<void> getProviderProfile() async {
    try {
      isLoading.value = true;

      final response = await _apiClient.get(
        url: ApiUrl.getProviderProfile,
        isToken: true,
      );

      if (response.statusCode == 200) {
        profile.value = ProviderProfileModel.fromJson(response.body);

        // ✅ Print all data to console for debugging
        print("💡 Provider Profile Fetched:");
        print("Full Name: ${profile.value?.data?.fullName}");
        print("Email: ${profile.value?.data?.email}");
        print("Phone: ${profile.value?.data?.phone}");
        print("Provider Profile Image: ${profile.value?.data?.provider?.profileImage}");
        print("Provider Specialization: ${profile.value?.data?.provider?.specialization}");
        print("Provider Type: ${profile.value?.data?.providerType?.label}");
        print("Services:");
        profile.value?.data?.services?.forEach((service) {
          print(" - ${service.title} : ${service.price}");
        });

      } else {
        AppSnackBar.fail(
          title: "Error",
          response.statusText ?? "Something went wrong",
        );
      }
    } catch (e) {
      AppSnackBar.fail(title: "Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

=======
>>>>>>> Stashed changes
}