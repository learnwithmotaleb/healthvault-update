import 'package:flutter/material.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../utils/app_colors/app_colors.dart';

class HealthArticleInfoCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const HealthArticleInfoCard({
    super.key,
    required this.image,
    required this.title,
    required this.description, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        height: Dimensions.h(255),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: AppColors.primaryColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.hintColor.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              ClipRRect(
                child: Image.network(
                  image,
                  width: double.infinity,
                  height:Dimensions.h(148),
                  fit: BoxFit.cover,
                ),
              ),
          
              /// Content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.loginLogoRadiusColor
                      )
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
