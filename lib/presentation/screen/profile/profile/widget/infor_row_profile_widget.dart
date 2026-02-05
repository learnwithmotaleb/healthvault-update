import 'package:flutter/material.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';


class InfoRowProfile extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRowProfile({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: Dimensions.w(8)),
        Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
