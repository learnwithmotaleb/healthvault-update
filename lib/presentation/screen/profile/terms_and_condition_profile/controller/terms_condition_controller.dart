import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../model/model.dart';


class TermsConditionController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  var isLoading = false.obs;
  var termsData = Rx<Data?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchTerms();
  }

  Future<void> fetchTerms() async {
    try {
      isLoading.value = true;

      final response = await _apiClient.get(
        url: ApiUrl.getTermsAndCondition,
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = TermsAndConditionModel.fromJson(response.body);
        termsData.value = model.data;
      } else {
        AppSnackBar.fail(response.body['message'] ?? "Failed to load terms");
      }
    } catch (e) {
      AppSnackBar.fail("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
