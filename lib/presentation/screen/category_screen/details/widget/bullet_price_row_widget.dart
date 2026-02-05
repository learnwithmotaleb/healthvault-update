import 'package:flutter/cupertino.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';

class BulletPriceRow extends StatelessWidget {
  final String title;
  final String price;

  const BulletPriceRow({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // row spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6), // text vertical align
            decoration: const BoxDecoration(
              color: AppColors.loginLogoRadiusColor,
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: Dimensions.w(12)),

          // Text
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.body,
                children: [
                  TextSpan(text: title,style: AppTextStyles.body.copyWith(
                    color: AppColors.blackColor
                  )),
                  TextSpan(
                    text: " - $price",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.loginLogoRadiusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
