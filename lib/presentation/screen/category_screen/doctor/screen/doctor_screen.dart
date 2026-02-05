import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/routes/route_path.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/doctor_controller.dart';
import '../widget/doctor_card.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final providerTypeId = args["providerTypeId"] ?? '';
    final providerTypeLabel = args["providerTypeLabel"] ?? AppStrings.doctor.tr;

    final doctorController = Get.put(DoctorController(apiClient: ApiClient()));

    // Fetch doctors when screen opens
    doctorController.fetchDoctors(providerTypeId);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: providerTypeLabel.toString().tr),
      body: Obx(() {
        if (doctorController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (doctorController.doctors.isEmpty) {
          return const Center(child: Text("No doctors found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: doctorController.doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctorController.doctors[index];

            // Extract doctor details safely
            final user = (doctor["user"] as List<dynamic>?)?.first ?? {};
            final servicesList = doctor["serviceId"] as List<dynamic>? ?? [];
            final availability = <String, String>{};

            // Optional: If you have a real availability list in API, parse it here
            // For now, we’ll add a dummy availability example
            availability["Saturday"] = "6:30 PM - 10:30 PM\n6:30 PM - 10:30 PM";
            availability["Friday"] = "6:30 PM - 10:30 PM";

            return DoctorsCard(
              name: user["fullName"] ?? doctor["fullName"] ?? 'N/A',
              type: doctor["displayName"] ?? 'N/A',
              address: doctor["address"] ?? 'N/A',
              imagePath: doctor["identification_images"] != null &&
                  doctor["identification_images"].toString().isNotEmpty
                  ? ApiUrl.buildImageUrl(doctor["identification_images"])
                  : AppImages.appLogo,
              services: servicesList.map((e) => e.toString()).toList(),
              availability: availability,

              onFavoriteTap: () {
                doctorController.addFavorite(doctor["providerTypeId"]);
              },

              onViewDetails: () {
                Get.toNamed(
                  RoutePath.infoProviderDetails,
                  arguments: {
                    "profileId": user["profileId"],        // ✅ required for API
                  },
                );
              },
            );
          },
        );
      }),
    );
  }
}
