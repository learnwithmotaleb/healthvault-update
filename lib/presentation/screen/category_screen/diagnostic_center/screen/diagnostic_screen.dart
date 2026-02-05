import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/screen/home/widgets/pharmacy_card_widget.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';

import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../widget/medical_card_widget.dart';

class DiagnosticScreen extends StatelessWidget {
  DiagnosticScreen({super.key});

  final List<Map<String, dynamic>> doctorsData = [
    {
      "name": "Dr. Abdul Motaleb",
      "type": "Cardiologist",
      "address": "Dhaka Medical College, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "General Consultation",
        "Heart Checkup",
        "24/7 Support",
      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",

      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",
        "Laser Therapy",

      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",
        "Laser Therapy",
        "Hair Treatment",

      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",
        "Laser Therapy",
        "Hair Treatment",

      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",
        "Laser Therapy",
        "Hair Treatment",
        "Online Consultation",

      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",
        "Laser Therapy",

      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",
        "Laser Therapy",
      ],
    },
    {
      "name": "Dr. Hasan Mahmud",
      "type": "Dermatologist",
      "address": "Square Hospital, Dhaka",
      "image": AppImages.motalebImage,
      "services": [
        "Skin Consultation",
        "Acne Treatment",
        "Laser Therapy",
        "Hair Treatment",
        "Online Consultation",
      ],
    },
  ];

  //18254004701
  //


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:  CommonAppBar(title: AppStrings.diagnosticCenters.tr),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: doctorsData.length,
          itemBuilder: (context, index) {

            final doctor = doctorsData[index];


            return MedicalServiceCard(
              name: doctor["name"],
              type: doctor["type"],
              address: doctor["address"],
              imagePath: doctor["image"],
              services: List<String>.from(doctor["services"]),
              onFavoriteTap: () {
                debugPrint("Favorite: ${doctor["name"]}");
              },
              onViewDetails: () {
                debugPrint("View Details: ${doctor["name"]}");
              },
            );
          },
        ),
      ),
    );
  }
}





