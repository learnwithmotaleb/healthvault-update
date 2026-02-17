import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';

import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../home/widgets/pharmacy_card_widget.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {

  final List<Map<String, dynamic>> pharmacyData = [
    {
      "name": "Monastiraki Pharmacy",
      "type": "Pharmacy",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Medicine Home Delivery",
        "24/7 Pharmacy Service",
        "Prescription Refill",
        "Online Order",
        "Emergency Medicine",
        "Health Consultation",
        "Baby Care Products",
        "Diabetic Care",
        "Medical Equipment",
        "Customer Support",
      ],
      "availability": {
        "Saturday": "9:00 AM - 11:00 PM",
        "Sunday": "9:00 AM - 11:00 PM",
        "Monday": "9:00 AM - 11:00 PM",
      },
    },
    {
      "name": "Monastiraki Pharmacy",
      "type": "Pharmacy",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Medicine Home Delivery",
        "24/7 Pharmacy Service",
        "Prescription Refill",
        "Online Order",
        "Emergency Medicine",
        "Health Consultation",
        "Baby Care Products",
        "Diabetic Care",
        "Medical Equipment",
        "Customer Support",
      ],
      "availability": {
        "Saturday": "9:00 AM - 11:00 PM",
        "Sunday": "9:00 AM - 11:00 PM",
        "Monday": "9:00 AM - 11:00 PM",
      },
    },
    {
      "name": "Monastiraki Pharmacy",
      "type": "Pharmacy",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Medicine Home Delivery",
        "24/7 Pharmacy Service",
        "Prescription Refill",
        "Online Order",
        "Emergency Medicine",
        "Health Consultation",
        "Baby Care Products",
        "Diabetic Care",
        "Medical Equipment",
        "Customer Support",
      ],
      "availability": {
        "Saturday": "9:00 AM - 11:00 PM",
        "Sunday": "9:00 AM - 11:00 PM",
        "Monday": "9:00 AM - 11:00 PM",
      },
    },
    {
      "name": "Monastiraki Pharmacy",
      "type": "Pharmacy",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Medicine Home Delivery",
        "24/7 Pharmacy Service",
        "Prescription Refill",
        "Online Order",
        "Emergency Medicine",
        "Health Consultation",
        "Baby Care Products",
        "Diabetic Care",
        "Medical Equipment",
        "Customer Support",
      ],
      "availability": {
        "Saturday": "9:00 AM - 11:00 PM",
        "Sunday": "9:00 AM - 11:00 PM",
        "Monday": "9:00 AM - 11:00 PM",
      },
    },
    {
      "name": "Monastiraki Pharmacy",
      "type": "Pharmacy",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Medicine Home Delivery",
        "24/7 Pharmacy Service",
        "Prescription Refill",
        "Online Order",
        "Emergency Medicine",
        "Health Consultation",
        "Baby Care Products",
        "Diabetic Care",
        "Medical Equipment",
        "Customer Support",
      ],
      "availability": {
        "Saturday": "9:00 AM - 11:00 PM",
        "Sunday": "9:00 AM - 11:00 PM",
        "Monday": "9:00 AM - 11:00 PM",
      },
    },
    {
      "name": "City Care Pharmacy",
      "type": "Pharmacy",
      "address": "Gulshan, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Online Medicine Order",
        "Home Delivery",
        "Prescription Verification",
        "Emergency Support",
        "Health Supplements",
        "Baby Care",
        "Diabetic Supplies",
        "Medical Devices",
        "24/7 Service",
        "Customer Support",
      ],
      "availability": {
        "Saturday": "8:00 AM - 12:00 AM",
        "Sunday": "8:00 AM - 12:00 AM",
      },
    },
    {
      "name": "Care Plus Pharmacy",
      "type": "Pharmacy",
      "address": "Uttara, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Emergency Medicine",
        "Home Delivery",
        "Online Consultation",
        "Prescription Refill",
        "Health Checkup Kits",
        "Medical Accessories",
        "Customer Support",
        "Baby Care",
        "Wellness Products",
        "24/7 Service",
      ],
      "availability": {
        "Everyday": "24 Hours Open",
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:  CommonAppBar(title: AppStrings.pharmacy.tr),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:Center()
      ),
    );
  }
}
