
import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';


class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontFamily: "poppins",
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );

  static  TextStyle label = TextStyle(
    fontFamily: "poppins",
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.labelColor,
  );

  static const TextStyle body = TextStyle(
    fontFamily: "poppins",
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  );

  static  TextStyle hint = TextStyle(
    fontFamily: "poppins",
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.hintColor.withOpacity(0.5),
  );


  static const TextStyle button = TextStyle(
    fontFamily: "poppins",
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
}
