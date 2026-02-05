import 'package:flutter/material.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../utils/app_colors/app_colors.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String service;
  final String price;
  final String dateTime;
  final String status;
  final Color statusColor;
  final VoidCallback? onTap;

  const AppointmentCard({
    Key? key,
    required this.doctorName,
    required this.service,
    required this.price,
    required this.dateTime,
    required this.status,
    this.statusColor = AppColors.primaryColor, this.onTap, // Default status color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.normal
                  )
                ),
                 SizedBox(height: Dimensions.h(5)),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.hintColor,
                    ),
                    children: [
                      TextSpan(text: service),
                      TextSpan(text: ' • '),
                      TextSpan(text: price,style: AppTextStyles.body.copyWith(
                        color: AppColors.primaryColor
                      )),
                    ],
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  dateTime,
                  style:AppTextStyles.body.copyWith(
                color: AppColors.hintColor
                )
                ),
              ],
            ),
            // Right Side Button
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
               style: AppTextStyles.body.copyWith(
              color: AppColors.whiteColor,
                 fontSize: 14
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
