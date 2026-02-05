import 'package:flutter/material.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ServiceCardWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ServiceCardWidget({
    super.key,
    required this.data,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.h(185),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(5),
        color:AppColors.primaryColor.withOpacity(0.1),
      ),

      /// ✔ FIX: NO SCROLL VIEW HERE
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// LEFT IMAGE
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: _buildImage(data["image"]),
            ),
          ),

          const SizedBox(width: 12),

          /// TEXT CONTENT (flexible)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["title"],
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              
                  const SizedBox(height: 4),
              
                  Text(
                    data["subtitle"],
                    style: AppTextStyles.body.copyWith(
                        color: AppColors.blackColor
                    ),
                  ),
              
                  const SizedBox(height: 4),
              
                  Text(
                    data["address"],
                    style: const TextStyle(color: Colors.black54),
                  ),
              
                  const SizedBox(height: 4),
              
                  Text(
                    data["description"],
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
                  child: Icon(Icons.edit, size: 20, color: AppColors.loginLogoRadiusColor)),
              SizedBox(width: Dimensions.w(10),),

              GestureDetector(
                onTap: onDelete,
                  child: Icon(Icons.delete, size: 20, color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  /// Supports both asset and network images
  Widget _buildImage(String path) {
    if (path.startsWith("http")) {
      return Image.network(
        path,
        width: 92,
        height: 106,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        path,
        width: 92,
        height: 106,
        fit: BoxFit.cover,
      );
    }
  }
}
