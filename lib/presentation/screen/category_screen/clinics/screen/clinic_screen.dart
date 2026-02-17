import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/screen/home/widgets/pharmacy_card_widget.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../utils/assets_image/app_images.dart';

class ClinicScreen extends StatelessWidget {
  ClinicScreen({super.key});

  final List<Map<String, dynamic>> clinicsData = [
    {
      "name": "Uptown Medical Clinic",
      "type": "General Clinic",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "General Health Checkup",
        "Blood Test",
        "ECG",
        "Urine Test",
        "X-Ray",
        "Vaccination",
        "Online Appointment",
        "Emergency Support",
        "Follow-up Visit",
        "24/7 Support",
      ],
      "availability": {
        "Monday": "8:00 AM - 8:00 PM",
        "Tuesday": "8:00 AM - 8:00 PM",
        "Wednesday": "8:00 AM - 8:00 PM",
      },
    },
    {
      "name": "Uptown Medical Clinic",
      "type": "General Clinic",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "General Health Checkup",
        "Blood Test",
        "ECG",
        "Urine Test",
        "X-Ray",
        "Vaccination",
        "Online Appointment",
        "Emergency Support",
        "Follow-up Visit",
        "24/7 Support",
      ],
      "availability": {
        "Monday": "8:00 AM - 8:00 PM",
        "Tuesday": "8:00 AM - 8:00 PM",
        "Wednesday": "8:00 AM - 8:00 PM",
      },
    },
    {
      "name": "Uptown Medical Clinic",
      "type": "General Clinic",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "General Health Checkup",
        "Blood Test",
        "ECG",
        "Urine Test",
        "X-Ray",
        "Vaccination",
        "Online Appointment",
        "Emergency Support",
        "Follow-up Visit",
        "24/7 Support",
      ],
      "availability": {
        "Monday": "8:00 AM - 8:00 PM",
        "Tuesday": "8:00 AM - 8:00 PM",
        "Wednesday": "8:00 AM - 8:00 PM",
      },
    },
    {
      "name": "Uptown Medical Clinic",
      "type": "General Clinic",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "General Health Checkup",
        "Blood Test",
        "ECG",
        "Urine Test",
        "X-Ray",
        "Vaccination",
        "Online Appointment",
        "Emergency Support",
        "Follow-up Visit",
        "24/7 Support",
      ],
      "availability": {
        "Monday": "8:00 AM - 8:00 PM",
        "Tuesday": "8:00 AM - 8:00 PM",
        "Wednesday": "8:00 AM - 8:00 PM",
      },
    },
    {
      "name": "Uptown Medical Clinic",
      "type": "General Clinic",
      "address": "Dhanmondi, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "General Health Checkup",
        "Blood Test",
        "ECG",
        "Urine Test",
        "X-Ray",
        "Vaccination",
        "Online Appointment",
        "Emergency Support",
        "Follow-up Visit",
        "24/7 Support",
      ],
      "availability": {
        "Monday": "8:00 AM - 8:00 PM",
        "Tuesday": "8:00 AM - 8:00 PM",
        "Wednesday": "8:00 AM - 8:00 PM",
      },
    },
    {
      "name": "Green Valley Clinic",
      "type": "Family Clinic",
      "address": "Gulshan, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Family Consultation",
        "Child Health Checkup",
        "Women Health Services",
        "Vaccination",
        "Online Appointment",
        "Minor Surgery",
        "Ultrasound",
        "Prescription Refill",
        "Follow-up Visit",
        "Customer Support",
      ],
      "availability": {
        "Monday": "9:00 AM - 9:00 PM",
        "Thursday": "9:00 AM - 9:00 PM",
        "Friday": "9:00 AM - 9:00 PM",
      },
    },
    {
      "name": "Sunrise Health Clinic",
      "type": "Specialist Clinic",
      "address": "Uttara, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Specialist Consultation",
        "Diagnostic Tests",
        "ECG",
        "Blood Pressure Check",
        "Vaccination",
        "Health Counseling",
        "Online Appointment",
        "Follow-up Visit",
        "Emergency Support",
        "24/7 Service",
      ],
      "availability": {
        "Everyday": "7:00 AM - 10:00 PM",
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:  CommonAppBar(title: AppStrings.clinics.tr),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:Center(),
      ),
    );
  }
}
