import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../appointment/widget/appointment_card.dart';
import '../controller/provider_task_controller.dart';

class ProviderTaskScreen extends StatefulWidget {
  const ProviderTaskScreen({super.key});

  @override
  State<ProviderTaskScreen> createState() => _ProviderTaskScreenState();
}

class _ProviderTaskScreenState extends State<ProviderTaskScreen> {

  final homeController = Get.put(ProviderTaskController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.task.tr, showBack: false, ),
      body: Column(
        children: [
          // Recent Appointments Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(10)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.allRequests.tr,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h(10),),


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
