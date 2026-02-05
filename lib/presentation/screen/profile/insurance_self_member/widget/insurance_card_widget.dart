import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';

class InsuranceCard extends StatelessWidget {
  final String? image;
  final String insName;
  final String insNumber;
  final String provider;
  final String expDate;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InsuranceCard({
    super.key,
     this.image,
    required this.insName,
    required this.insNumber,
    required this.provider,
    required this.expDate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// MAIN CARD
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.h(5)),
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
                /// LEFT IMAGE
                SizedBox(
                  width: Dimensions.w(80),
                  height: Dimensions.h(80),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: Dimensions.w(10)),

                /// MIDDLE TEXT COLUMN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText("Ins Name: ", insName),
                      buildText("Ins Number: ", insNumber),
                      buildText("Ins Provider: ", provider),
                      buildText("Exp Date: ", expDate),
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
