import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final double? width; // <-- Added

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.width, // <-- Added
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: width ?? Dimensions.w(100),   // <-- Dynamic width support
        height: Dimensions.h(90),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColors.primaryColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Dimensions.w(40),
              height: Dimensions.h(40),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: AppTextStyles.body.copyWith(
                color: AppColors.blackColor,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
