import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../widget/custom_appbar.dart';
import '../simmer_effect/simmer_effect.dart';
import '../widget/appointment_card.dart';
import '../controller/appointment_controller.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.myAppointments.tr,
        showBack: false,
      ),
      body: Obx(() {
        // ── Loading state → shimmer ──
        if (controller.isLoading.value) {
          return const AppointmentListShimmer(itemCount: 6);
        }

        // ── Empty state ──
        if (controller.appointments.isEmpty) {
          return const Center(
            child: Text("No Appointments Found"),
          );
        }

        // ── Loaded state ──
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.appointments.length,
                itemBuilder: (context, index) {
                  final appointment = controller.appointments[index];

                  final normalUser = appointment.normalUserId;
                  final provider = appointment.providerId;
                  final service = appointment.serviceId;

                  return AppointmentCard(
                    doctorName: provider?.fullName ?? "Unknown",
                    service: service?.title ?? "N/A",
                    price: "${service?.price ?? ""}",
                    dateTime: appointment.appointmentDateTime ?? "",
                    status: appointment.status ?? "",
                    onTap: () {
                      Get.toNamed(
                        RoutePath.details,
                        arguments: {
                          "normalUser": normalUser,
                          "provider": provider,
                          "service": service,
                          "appointment": appointment,
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}