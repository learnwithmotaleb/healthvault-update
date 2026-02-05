import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';

class HealthLogCard extends StatelessWidget {
  final String familyMember;
  final String bloodPressure;
  final String heartRate;
  final String weight;
  final String bloodSugar;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HealthLogCard({
    super.key,

    required this.onEdit,
    required this.onDelete,
    required this.weight,
    required this.familyMember,
    required this.bloodPressure,
    required this.heartRate,
    required this.bloodSugar,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// MAIN CARD
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.h(5)),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.h(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                /// MIDDLE TEXT COLUMN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText("Family Member Name: ", familyMember),
                      buildText("Blood Pressure ", bloodPressure),
                      buildText("heartRate: ", bloodPressure),
                      buildText("weight: ", weight),
                      buildText("Blood Sugar: ", bloodSugar),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// TOP RIGHT ACTION BUTTONS
        Positioned(
          right: 5,
          top: 5,
          child: Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Icon(Icons.edit, size: 18, color: AppColors.primaryColor),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.delete, size: 18, color: AppColors.emergencyColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Reusable text row
  Widget buildText(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(4)),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: AppColors.blackColor,
              ),
            ),
            TextSpan(
              text: value,
              style: AppTextStyles.body.copyWith(
                color: AppColors.blackColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
