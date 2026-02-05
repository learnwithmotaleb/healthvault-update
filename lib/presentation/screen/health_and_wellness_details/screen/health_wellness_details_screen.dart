import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';
import '../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../widget/custom_appbar.dart';
import '../controller/health_wellness_details_controller.dart';

class HealthWellnessDetailsScreen extends StatelessWidget {
  HealthWellnessDetailsScreen({super.key});

  final HealthWellnessDetailsController controller =
  Get.put(HealthWellnessDetailsController());

  @override
  Widget build(BuildContext context) {
    // Get articleId from arguments
    final String articleId = Get.arguments?['articleId'] ?? '';
    print("======================================");
    print(articleId.toString());

    print("======================================");


    // Fetch article once
    controller.fetchArticle(articleId);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.healthANDWellnessArticles.tr,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final article = controller.article.value;

        if (article == null) {
          return const Center(child: Text("Article not found"));
        }

        final imageUrl = article.articleImage != null
            ? ApiUrl.buildImageUrl(article.articleImage!)
            : null;

        return RefreshIndicator(
          onRefresh: () => controller.fetchArticle(articleId),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- IMAGE ----------
                  if (imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: Dimensions.h(180),
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: Dimensions.h(10)),

                  // ---------- TITLE ----------
                  Text(
                    article.title ?? '',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.loginLogoRadiusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(16)),

                  // ---------- DETAILS ----------
                  Text(
                    article.details ?? '',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.hintColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
