import 'package:flutter/material.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ServiceCardWidget extends StatelessWidget {
  // ✅ Direct named parameters instead of Map
  final String title;
  final String subtitle;
  final String address;
  final String description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ServiceCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.address,
    required this.description,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.h(110),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor.withOpacity(0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// TEXT CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, // ✅ direct variable
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle, // ✅ direct variable
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address, // ✅ direct variable
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description, // ✅ direct variable
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          /// RIGHT ACTION BUTTONS
          Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Icon(Icons.edit, size: 20, color: AppColors.loginLogoRadiusColor),
              ),
              SizedBox(width: Dimensions.w(10)),
              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.delete, size: 20, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}