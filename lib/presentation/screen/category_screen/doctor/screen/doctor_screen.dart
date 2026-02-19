import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/routes/route_path.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../profile/favourite_profile/controller/favourite_controller.dart';
import '../controller/doctor_controller.dart';
import '../simmer/simmer_effect.dart';
import '../widget/doctor_card.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final doctorController = Get.put(DoctorController(apiClient: ApiClient()));
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
        // ── Loading state → shimmer ──
        if (doctorController.isLoading.value) {
          return const DoctorListShimmer(itemCount: 5);
        }

        // ── Empty state ──
        if (doctorController.doctors.isEmpty) {
          return const Center(child: Text("No doctors found"));
        }

        // ── Loaded state ──
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: doctorController.doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctorController.doctors[index];

            final user =
                (doctor["user"] as List<dynamic>?)?.first ?? {};
            final servicesList =
                doctor["services"] as List<dynamic>? ?? [];
            final serviceTitles = servicesList
                .map((s) =>
            (s as Map<String, dynamic>)["title"]?.toString() ?? "")
                .toList();

            final providerId = doctor["_id"]?.toString() ??
                doctor["id"]?.toString() ??
                user["profileId"]?.toString() ??
                '';

            // Build availability map
            final availabilityDaysList =
                doctor["availabilityDays"] as List<dynamic>? ?? [];
            final availability = <String, String>{};
            for (var day in availabilityDaysList) {
              final dayMap = day as Map<String, dynamic>;
              final dayOfWeek = dayMap["dayOfWeek"]?.toString() ?? "";
              final slots =
              (dayMap["availabilitySlots"] as List<dynamic>? ?? [])
                  .map((s) {
                final slot = s as Map<String, dynamic>;
                return "From: ${slot["startTime"]} - To: ${slot["endTime"]}";
              })
                  .join("\n");
              availability[dayOfWeek] = slots;
            }

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
              isFavorite: favouriteController.isFavorite(providerId),
              onFavoriteTap: () {
                setState(() {});
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