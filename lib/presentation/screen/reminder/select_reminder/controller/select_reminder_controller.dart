import 'package:get/get.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../service/api_service.dart';
import '../../model/get_all_reminder.dart' as reminder_model;

class SelectReminderController extends GetxController {
  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;
  RxList<reminder_model.Data> reminders = <reminder_model.Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllReminders();
  }

  /// Fetch all reminders from the API
  Future<void> getAllReminders() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.myReminder,
        isToken: true,
      );

      if (response.statusCode == 200) {
        try {
          final model = reminder_model.GetReminderAll.fromJson(response.body);

          if (model.success == true) {
            // Assign data to the observable list
            reminders.assignAll(model.data ?? []);
          } else {
            AppSnackBar.fail(title: "Health Vault", model.message ?? "Something went wrong");
          }
        } catch (e) {
          AppSnackBar.fail(title: "Health Vault", "Parsing error: $e");
        }
      } else {
        AppSnackBar.fail(title: "Health Vault", "API Error: ${response.statusText}");
      }
    } catch (e) {
      AppSnackBar.fail(title: "Health Vault","Network error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete a reminder by ID
  Future<void> deleteReminder(String id) async {
    try {
      isLoading.value = true;

      final response = await apiClient.delete(
        url: ApiUrl.deleteReminder(id), // <-- your delete URL
        isToken: true,
      );

      if (response.statusCode == 200) {
        // Parse success
        final success = response.body['success'] ?? false;
        final message = response.body['message'] ?? 'Deleted successfully';

        if (success) {
          // Remove from local list immediately
          reminders.removeWhere((element) => element.sId == id);
          AppSnackBar.success(title: "Health Vault", message);
        } else {
          AppSnackBar.fail(title: "Health Vault", message);
        }
      } else {
        AppSnackBar.fail(title: "Health Vault", "API Error: ${response.statusText}");
      }
    } catch (e) {
      AppSnackBar.fail(title: "Health Vault", "Network error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  /// Refresh function for pull-to-refresh
  Future<void> refreshReminders() async {
    await getAllReminders();
  }
}
