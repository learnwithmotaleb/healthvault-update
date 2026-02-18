import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/routes/route_path.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../profile/favourite_profile/controller/favourite_controller.dart';  // ✅ import
import '../controller/doctor_controller.dart';
import '../widget/doctor_card.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {

  final doctorController = Get.put(DoctorController(apiClient: ApiClient()));
  // ✅ Find shared FavouriteController
  final favouriteController = Get.find<FavouriteController>();


  late String providerTypeId;
  late String providerTypeLabel;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments ?? {};
    providerTypeId = args["providerTypeId"] ?? '';
    providerTypeLabel = args["providerTypeLabel"] ?? AppStrings.doctor.tr;

    doctorController.fetchDoctors(providerTypeId);
  }







  @override
  Widget build(BuildContext context) {

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

            final user = (doctor["user"] as List<dynamic>?)?.first ?? {};
            final servicesList = doctor["services"] as List<dynamic>? ?? [];
            final serviceTitles = servicesList
                .map((s) => (s as Map<String, dynamic>)["title"]?.toString() ?? "")
                .toList();

            // ✅ Get the correct provider ID (adjust field name based on your model)
            final providerId = doctor["_id"]?.toString() ??
                doctor["id"]?.toString() ??
                user["profileId"]?.toString() ?? '';

            final availability = <String, String>{};
            availability["Saturday"] = "6:30 PM - 10:30 PM\n6:30 PM - 10:30 PM";
            availability["Friday"] = "6:30 PM - 10:30 PM";

            return DoctorsCard(
              name: user["fullName"] ?? doctor["fullName"] ?? 'N/A',
              type: user["email"] ?? 'N/A',
              address: doctor["address"] ?? 'N/A',
              imagePath: doctor["identification_images"] != null &&
                  doctor["identification_images"].toString().isNotEmpty
                  ? ApiUrl.buildImageUrl(doctor["identification_images"])
                  : AppImages.appLogo,
              services: serviceTitles,
              availability: availability,

              // ✅ Read from FavouriteController
              isFavorite: favouriteController.isFavorite(providerId),

              // ✅ Toggle using FavouriteController with correct ID
              onFavoriteTap: () {
                setState(() {

                });
                favouriteController.toggleFavorite(
                  providerId,
                  providerName: user["fullName"] ?? doctor["fullName"],

                );

              },

              onViewDetails: () {
                Get.toNamed(
                  RoutePath.infoProviderDetails,
                  arguments: {"profileId": user["profileId"]},
                );
              },
            );
          },
        );
      }),
    );
  }
}