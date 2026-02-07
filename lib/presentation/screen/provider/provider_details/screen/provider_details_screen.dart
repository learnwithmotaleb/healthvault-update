import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/hv_button.dart';
import '../controller/provider_details_controller.dart';
import '../widget/provider_detalis_service_card.dart';

class ProviderDetailsScreen extends StatefulWidget {
  const ProviderDetailsScreen({super.key});

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  final controller = Get.find<ProviderDetailsController>();

  @override
  void initState() {
    super.initState();
    final appointmentId = Get.arguments;
    controller.getAppointmentDetails(appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppStrings.details.tr),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.appointment.value;
        if (data == null) {
          return const Center(child: Text("No appointment details found"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(height: Dimensions.h(5)),

              /// 🔹 User Info Card
              Container(
                width: Dimensions.w(400),
                height: Dimensions.h(136),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withOpacity(0.1),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.network(
                          data.normalUserId?.profileImage ?? "",
                          width: Dimensions.w(80),
                          height: Dimensions.h(80),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Image.asset(AppImages.motalebImage,   width: Dimensions.w(80),
                                height: Dimensions.h(80),),
                        ),
                      ),
                      SizedBox(width: Dimensions.w(24)),
                      Text(
                        data.normalUserId?.fullName ?? "",
                        style: AppTextStyles.label.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Dimensions.h(16)),

              /// 🔹 Service Card
              ServiceCard(
                serviceName: data.serviceId?.title ?? "",
                scheduleDate: data.appointmentDateTime ?? "",
                scheduleText: data.status ?? "",
                bookingDate: data.createdAt ?? "",
                time: data.appointmentDateTime ?? "",
                location: data.providerId?.address ?? "",
                reason: data.reasonForVisit ?? "",
              ),

              SizedBox(height: Dimensions.h(30)),

              /// 🔹 View Document Button
              HVButton(
                label: AppStrings.viewDocument.tr,
                backgroundColor: AppColors.whiteColor,
                borderSideColor: AppColors.whiteColor,
                textColor: AppColors.primaryColor,
                onPressed: () {
                  Get.toNamed(
                    RoutePath.appalmentDocument,
                    arguments: data.appointmentImages,
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
