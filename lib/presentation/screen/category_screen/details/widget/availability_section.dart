import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';

class AvailabilitySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Map<String, String>> items;

  const AvailabilitySection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.primaryColor.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.h(20)),

          /// Horizontal list
          SizedBox(
            height: Dimensions.w(85),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  width: Dimensions.w(220),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['day'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['time'] ?? '',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: Dimensions.h(20)),
        ],
      ),
    );
  }
}
