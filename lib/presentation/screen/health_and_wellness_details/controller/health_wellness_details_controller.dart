import 'package:get/get.dart';
import '../../../../service/api_service.dart';
import '../../../../service/api_url.dart';
import '../../health_and_wellness_article/controller/health_article_controller.dart';
import '../article_details_model.dart';


class HealthWellnessDetailsController extends GetxController {
  final ApiClient apiClient = ApiClient();

  var isLoading = false.obs;
  var article = Rxn<Data>();

  // Reference the HealthArticleController
  final HealthArticleController _articleController = Get.find<HealthArticleController>();

  @override
  void onInit() {
    super.onInit();
    final selectedId = _articleController.selectedArticleId.value;
    if (selectedId.isNotEmpty) {
      fetchArticle(selectedId);
    } else {
      print("No article selected");
    }

    print(selectedId.toString());
  }

  /// Fetch single article by ID
  Future<void> fetchArticle(String id) async {
    try {
      isLoading.value = true;
      final response = await apiClient.get(
        url: ApiUrl.getSingeArticle(id),
        isToken: true,
      );

      if (response.statusCode == 200 && response.body != null) {
        final model = ArticalDetailsModel.fromJson(response.body);
        article.value = model.data;
      } else {
        print("Error fetching article: ${response.statusText}");
      }
    } catch (e) {
      print("Exception fetching article: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
