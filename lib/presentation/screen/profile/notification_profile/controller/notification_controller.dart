import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../service/api_service.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Pagination state
  int _page = 1;
  final int _limit = 10;
  int _totalPage = 1;

  var isLoading = false.obs;
  var hasMore = true.obs;

  // Notification list
  RxList<Result> notificationList = <Result>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllNotifications();
  }

  /// ================= Get Notifications =================
  Future<void> getAllNotifications({bool loadMore = false}) async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    final url =
        "${ApiUrl.getAllNotification}?page=$_page&limit=$_limit";

    final response = await _apiClient.get(
      url: url,
      isToken: true,
    );

    if (response.statusCode == 200) {
      final model = NotificationModel.fromJson(response.body);

      final data = model.data;
      final meta = data?.meta;
      final results = data?.result ?? [];

      _totalPage = meta?.totalPage ?? 1;

      if (!loadMore) {
        notificationList.clear();
      }

      notificationList.addAll(results);

      if (_page >= _totalPage) {
        hasMore.value = false;
      } else {
        _page++;
      }
    }

    isLoading.value = false;
  }

  /// ================= Delete Notification =================
  Future<void> deleteNotification(String notificationId) async {
    final url = ApiUrl.removeNotification(notificationId);

    final response = await _apiClient.delete(
      url: url,
      isToken: true,
    );

    if (response.statusCode == 200) {
      // Remove from list instantly (smooth UX)
      notificationList.removeWhere(
            (item) => item.sId == notificationId,
      );

      Get.snackbar(
        "Success",
        "Notification deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        "Failed to delete notification",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  /// ================= Load More =================
  void loadMoreNotifications() {
    if (hasMore.value) {
      getAllNotifications(loadMore: true);
    }
  }
}
