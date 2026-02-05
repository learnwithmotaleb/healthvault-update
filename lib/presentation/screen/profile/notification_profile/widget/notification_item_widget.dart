import 'package:flutter/material.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';

Widget notificationItem({
  required String id,
  required String title,
  required String message,
  required VoidCallback onDelete,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: Dimensions.h(12)),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(Dimensions.r(8)),
      border: Border.all(
        color: AppColors.greyColor.withOpacity(.2),
        width: Dimensions.w(.8),
      ),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,

      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          fontSize: Dimensions.f(12),
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),

      subtitle: Text(
        message,
        style: AppTextStyles.body.copyWith(
          fontSize: Dimensions.f(12),
          color: AppColors.blackColor,
          height: 1.45,
        ),
      ),

      trailing: IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: AppColors.primaryColor,
          size: Dimensions.w(22),
        ),
        onPressed: onDelete,
      ),
    ),
  );
}
