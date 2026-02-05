import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/screen/home/widgets/pharmacy_card_widget.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../utils/assets_image/app_images.dart';
import '../../diagnostic_center/widget/medical_card_widget.dart';

class PlasticScreen extends StatelessWidget {
  PlasticScreen({super.key});

  final List<Map<String, dynamic>> plasticData = [
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:  CommonAppBar(title: AppStrings.plasticSurgery.tr),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: plasticData.length,
          itemBuilder: (context, index) {

            final plastic = plasticData[index];


            return MedicalServiceCard(
              name: plastic["name"],
              type: plastic["type"],
              address: plastic["address"],
              imagePath: plastic["image"],
              services: List<String>.from(plastic["services"]),
              onFavoriteTap: () {
                debugPrint("Favorite: ${plastic["name"]}");
              },
              onViewDetails: () {
                debugPrint("View Details: ${plastic["name"]}");
              },
            );
          },
        ),
      ),
    );
  }
}





