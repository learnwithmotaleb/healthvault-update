import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String fromTime;
  final String toTime;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ScheduleCard({
    super.key,
    required this.day,
    required this.fromTime,
    required this.toTime,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            /// DAY + ACTION BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    day,
                    style: AppTextStyles.body.copyWith(
                        fontSize: 16,
                        color: AppColors.whiteColor
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
        
                Row(
                  children: [
                    InkWell(
                      onTap: onEdit,
                      child: Icon(Icons.edit, color: AppColors.whiteColor, size: 20),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: onDelete,
                      child: const Icon(Icons.close, color:  AppColors.readColor, size: 20),
                    ),
                  ],
                ),
              ],
            ),
        
        
            /// RESPONSIVE TIME ROW
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.form.tr, style: AppTextStyles.body.copyWith(
                        fontSize: 12,
                        color: AppColors.whiteColor
                      )
                      ),
                      Text(fromTime, style: AppTextStyles.body.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteColor
                      )),
                      Text(fromTime, style: AppTextStyles.body.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteColor
                      )),
        
        
                    ],
                  ),
                ),
        
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(AppStrings.to.tr, style: AppTextStyles.body.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteColor
                      )),
                      Text(toTime, style: AppTextStyles.body.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteColor
                      )),
                      Text(toTime, style: AppTextStyles.body.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteColor
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
