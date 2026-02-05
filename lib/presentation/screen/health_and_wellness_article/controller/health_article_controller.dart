import 'package:get/get.dart';
import '../../../../service/api_service.dart';
import '../../../../service/api_url.dart';
import '../model/article_model.dart';

class HealthArticleController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Reactive variables
  var isLoading = false.obs;
  var errorText = "".obs;
  var articles = <Article>[].obs;

  // Pagination
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  // Selected article ID for details screen
  var selectedArticleId = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialArticles();
  }

  /// Fetch first page of articles
  Future<void> fetchInitialArticles() async {
    _page = 1;
    _hasMore = true;
    articles.clear();
    await _fetchArticles(page: _page, append: false);
  }

  /// Fetch next page
  Future<void> fetchMoreArticles() async {
    if (isLoading.value || !_hasMore) return;
    _page += 1;
    await _fetchArticles(page: _page, append: true);
  }

  /// Set the selected article for details screen
  void selectArticle(String id) {
    selectedArticleId.value = id;
  }

  /// Internal fetch function
  Future<void> _fetchArticles({required int page, required bool append}) async {
    try {
      isLoading.value = true;
      errorText.value = "";

      final url = "${ApiUrl.getAllArticle}?page=$page&limit=$_limit";
      final res = await _apiClient.get(url: url, isToken: true);

      if (res.statusCode == 200 && res.body is Map<String, dynamic>) {
        final model = GetAllArticleModel.fromJson(res.body);
        final newArticles = model.data?.articles ?? [];

        if (append) {
          articles.addAll(newArticles);
        } else {
          articles.assignAll(newArticles);
        }

        final totalPage = model.data?.meta?.totalPage ?? page;
        _hasMore = page < totalPage;
      } else {
        final message = (res.body is Map && (res.body as Map).containsKey('message'))
            ? res.body['message'].toString()
            : res.statusText ?? "Request failed";
        errorText.value = message;
        if (append) _page -= 1;
      }
    } catch (e) {
      errorText.value = e.toString();
      if (append) _page -= 1;
    } finally {
      isLoading.value = false;
    }
  }
}
