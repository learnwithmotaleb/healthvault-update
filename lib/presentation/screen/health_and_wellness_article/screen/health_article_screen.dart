import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import '../../../../service/api_url.dart';
import '../controller/health_article_controller.dart';
import '../widget/heath_article_card_widget.dart';

class HealthArticleScreen extends StatelessWidget {
  HealthArticleScreen({super.key});

  final controller = Get.put(HealthArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Health & Wellness Articles"),
      body: Obx(() {
        if (controller.isLoading.value && controller.articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorText.value.isNotEmpty && controller.articles.isEmpty) {
          return Center(child: Text(controller.errorText.value));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchInitialArticles,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            itemCount: controller.articles.length + (controller.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              // Pagination loader at the bottom
              if (index == controller.articles.length) {
                controller.fetchMoreArticles();
                return const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final item = controller.articles[index];
              final imageUrl = item.articleImage != null
                  ? ApiUrl.buildImageUrl(item.articleImage!)
                  : null;

              return HealthArticleInfoCard(
                image: imageUrl ?? '',
                title: item.title ?? '',
                description: item.details ?? '',
                onTap: () {
                  Get.toNamed(
                    RoutePath.healthDetail,
                    arguments: {'articleId': item.id.toString()}, // ✅ pass as Map
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
