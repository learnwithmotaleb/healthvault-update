import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';

import '../model/model.dart';

class FaqsController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  var isLoading = false.obs;
  var faqs = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;

      final response = await _apiClient.get(
        url: ApiUrl.getFag,
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = FaqModel.fromJson(response.body);
        faqs.value = model.data ?? [];
      } else {
        AppSnackBar.fail(response.body['message'] ?? "Failed to load FAQ");
      }
    } catch (e) {
      AppSnackBar.fail("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
