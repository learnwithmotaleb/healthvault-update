import 'package:flutter/material.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../utils/app_colors/app_colors.dart';


class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryColor, size: 24),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTextStyles.body,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
