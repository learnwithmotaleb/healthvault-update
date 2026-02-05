
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';

class HVSnack {
  static void success(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.secondaryColor);
  }

  static void error(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.emergencyColor,
        colorText: Colors.white);
  }

  static void info(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade600,
        colorText: Colors.white);
  }
}
