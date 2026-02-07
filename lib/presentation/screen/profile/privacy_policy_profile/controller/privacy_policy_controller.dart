import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../model/model.dart';

class PrivacyPolicyController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  var isLoading = false.obs;
  var policyData = Rx<Data?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;

      final response = await _apiClient.get(
        url: ApiUrl.privacyPolicy,
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = PrivacyAndPolicyModel.fromJson(response.body);
        policyData.value = model.data;
      } else {
        AppSnackBar.fail(response.body['message'] ?? "Failed to load policy");
      }
    } catch (e) {
      AppSnackBar.fail("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
