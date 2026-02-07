import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/service/api_url.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';

class AppalmentDocumentScreen extends StatefulWidget {
  const AppalmentDocumentScreen({super.key});

  @override
  State<AppalmentDocumentScreen> createState() =>
      _AppalmentDocumentScreenState();
}

class _AppalmentDocumentScreenState extends State<AppalmentDocumentScreen> {
  List<String> images = [];
  static const String mainDomain = ApiUrl.mainDomain; // API base URL

  @override
  void initState() {
    super.initState();

    // Get images from arguments passed from previous screen
    final arg = Get.arguments;
    if (arg != null) {
      if (arg is String) {
        images = [buildImageUrl(arg)];
      } else if (arg is List<String>) {
        images = arg.map((e) => buildImageUrl(e)).toList();
      }
    }
  }

  /// 🔹 Helper to build full image URL from API path
  String buildImageUrl(String relativePath) {
    // Replace backslashes with forward slashes
    final path = relativePath.replaceAll(r'\', '/');
    return "$mainDomain/$path";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.appalmentDocument.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h(10)),
            Text(
              AppStrings.appalmentDocument.tr,
              style: AppTextStyles.body,
            ),
            SizedBox(height: Dimensions.h(10)),

            /// 🔹 Show Grid of Images
            images.isEmpty
                ? Expanded(
              child: Center(
                child: Text(
                  "No documents found",
                  style: AppTextStyles.body,
                ),
              ),
            )
                : SizedBox(
              height: Dimensions.h(200),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(Dimensions.h(5)),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Dimensions.h(10),
                  crossAxisSpacing: Dimensions.w(10),
                  childAspectRatio: 95.76 / 63.84,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final imageUrl = images[index];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.r(5)),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: Dimensions.w(95.76),
                      height: Dimensions.h(63.84),
                      errorBuilder: (_, __, ___) =>
                          Image.asset(AppImages.motalebImage),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
