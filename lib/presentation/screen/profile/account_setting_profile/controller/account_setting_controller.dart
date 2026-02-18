import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/helper/local_db/local_db.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';

import '../../../../../service/api_service.dart';

class AccountSettingController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  RxBool isLoading = false.obs;

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;

      final response = await _apiClient.delete(
        url: ApiUrl.deleteAccount,
        isToken: true,
      );

      if (response.statusCode == 200) {
        await SharePrefsHelper.clearAll();

        AppSnackBar.success(title:"Health Vault", "Account deleted successfully");

        Get.offAllNamed(RoutePath.onboard);
      } else {
        AppSnackBar.fail(
          title:"Health Vault",
            response.statusText ?? "Failed to delete account"

        );
      }
    } catch (e) {
      AppSnackBar.success("Something went wrong");

    } finally {
      isLoading.value = false;
    }
  }
}
