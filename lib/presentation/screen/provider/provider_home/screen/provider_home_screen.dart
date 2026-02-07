import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../appointment/widget/appointment_card.dart';
import '../../provider_profile/controller/provider_profile_controller.dart';
import '../controller/provider_home_controller.dart';
import 'package:healthvault/service/api_url.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({super.key});

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {

  final homeController = Get.put(ProviderHomeController());
  final profileController = Get.find<ProviderProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            height: Dimensions.h(155),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                child: Obx(() {
                  final user = profileController.profile.value?.data;
                  final provider = user?.provider;

                  if (profileController.isLoading.value) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: Dimensions.w(24),
                          backgroundColor: Colors.white,
                        ),
                        title: Container(
                          width: 120,
                          height: 16,
                          color: Colors.white,
                        ),
                        subtitle: Container(
                          width: 80,
                          height: 14,
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 4),
                        ),
                        trailing: Container(
                          width: Dimensions.w(40),
                          height: Dimensions.w(40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: Dimensions.w(24),
                      backgroundImage: (provider?.profileImage ?? "").isNotEmpty
                          ? NetworkImage(
                        "${ApiUrl.mainDomain}/${provider!.profileImage!.replaceAll("\\", "/")}",
                      )
                          : AssetImage(AppImages.motalebImage) as ImageProvider,
                    ),
                    title: Text(
                      user?.fullName ?? "Guest",
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      AppStrings.welcomeBack.tr,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.whiteColor.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () => Get.toNamed(RoutePath.notification),
                      child: Container(
                        width: Dimensions.w(40),
                        height: Dimensions.w(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.whiteColor.withOpacity(0.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          SizedBox(height: Dimensions.h(10)),

          // Total Appointments Card
          Center(
            // Total Appointments Card
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: Container(
                width: Dimensions.w(309),
                height: Dimensions.h(121),
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.providerSelectionColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Obx(() {
                    // Calculate counts
                    final total = homeController.appointments.length;
                    print("Total: $total");

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$total",
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.providerSelectionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: Dimensions.h(4)),
                        Text(
                          "Total",
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.providerSelectionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: Dimensions.h(4)),
                        Text(
                          AppStrings.appointmentRequest.tr,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.providerSelectionColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    );
                  }),
                ),
              ),
            ),

          ),

          SizedBox(height: Dimensions.h(16)),

          // Recent Appointments Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.recentAppointments.tr,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.providerHomePageColor,
                ),
              ),
            ),
          ),

          // Appointment List
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (_, __) => SizedBox(height: Dimensions.h(5)),
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                      height: Dimensions.h(80),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              }

              if (homeController.appointments.isEmpty) {
                return Center(
                  child: Text("No appointments found"),
                );
              }

              return ListView.separated(
                itemCount: homeController.appointments.length,
                separatorBuilder: (_, __) => SizedBox(height: Dimensions.h(5)),
                itemBuilder: (context, index) {
                  final appointment = homeController.appointments[index];
                  final user = appointment.normalUserId;
                  final service = appointment.serviceId;

                  return AppointmentCard(
                    doctorName: user?.fullName ?? "Unknown",
                    service: service?.title ?? "",
                    price: "\$${service?.price ?? 0}",
                    dateTime: appointment.appointmentDateTime ?? "",
                    status: appointment.status ?? "",
                    onTap: (){

                      Get.toNamed(RoutePath.providerDetails,
                        arguments: appointment.sId.toString(),
                      );
                    },
                  );
                },
              );

            }),
          ),
        ],
      ),
    );
  }
}
