import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/hv_button.dart';
import '../../../../widget/hv_text_field.dart';
import '../../../../widget/hv_validation.dart';
import '../../details/widget/add_document_widget.dart';
import '../../details/widget/date_picker_field.dart';
import '../../details/widget/select_your_service_field.dart';
import '../../details/widget/time_picker_filed.dart';
import '../controller/info_provider_details_controller.dart';

class InfoProviderDetailsScreen extends StatefulWidget {
  const InfoProviderDetailsScreen({super.key});

  @override
  State<InfoProviderDetailsScreen> createState() =>
      _InfoProviderDetailsScreenState();
}

class _InfoProviderDetailsScreenState
    extends State<InfoProviderDetailsScreen> {
  late InfoProviderDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(InfoProviderDetailsController());

    final args = Get.arguments ?? {};
    final profileId = args["profileId"];

    if (profileId != null) {
      controller.getProviderDetails(profileId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final provider = controller.provider.value;
          return CommonAppBar(
            title: provider?.fullName ?? AppStrings.doctor.tr,
          );
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final provider = controller.provider.value;

        if (provider == null) {
          return const Center(child: Text("No provider data"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              if (provider.profileImage != null)
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      ApiUrl.buildImageUrl(provider.profileImage!),
                    ),
                  ),
                ),
              SizedBox(height: Dimensions.h(10)),

              // Specialization
              Row(
                children: [
                  Text(AppStrings.specialisations.tr,
                      style: AppTextStyles.label),
                  Spacer(),
                  Text(provider.specialization ?? "N/A",
                      style: AppTextStyles.label),
                ],
              ),
              SizedBox(height: Dimensions.h(10)),

              // Address
              Text(AppStrings.address.tr, style: AppTextStyles.label),
              SizedBox(height: 4),
              Text(provider.address ?? "N/A"),
              SizedBox(height: Dimensions.h(10)),

              // Services
              const Text(
                "Services",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...(provider.services ?? [])
                  .map((s) => Text("• ${s.title} (${s.price})")),

              SizedBox(height: Dimensions.h(20)),

              // Appointment Form
              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reason
                    Text(AppStrings.reasonForVisit.tr,
                        style: AppTextStyles.label),
                    SizedBox(height: Dimensions.h(10)),
                    HVTextField(
                      controller: controller.reasonController,
                      hint: AppStrings.writeHere,
                      validator: AppValidators.required(),
                    ),
                    SizedBox(height: Dimensions.h(10)),

                    // Date
                    Text(AppStrings.selectYourDate.tr,
                        style: AppTextStyles.label),
                    SizedBox(height: Dimensions.h(10)),
                    DatePickerField(
                      controller: controller.selectYourDateController,
                      hintText: AppStrings.selectAppointmentDate.tr,
                      onDateSelected: (date) {
                        print("Selected date: $date");
                      },
                      validator: AppValidators.required(),
                    ),
                    SizedBox(height: Dimensions.h(10)),

                    // Time
                    Text(AppStrings.selectYourTime.tr,
                        style: AppTextStyles.label),
                    SizedBox(height: Dimensions.h(10)),
                    TimePickerField(
                      controller: controller.selectTimeController,
                      hintText: AppStrings.selectAppointmentTime.tr,
                      onTimeSelected: (time) {
                        print("Selected time: ${time.format(context)}");
                      },
                      validator: AppValidators.required(),
                    ),
                    SizedBox(height: Dimensions.h(12)),

                    // Documents
                    Text(AppStrings.addDocument.tr,
                        style: AppTextStyles.label),
                    SizedBox(height: Dimensions.h(12)),
                    // Upload box (100 x 100)
                    Obx(
                          () => GestureDetector(
                        onTap: () {
                          if (controller.pickedImage.value == null) {
                            controller.pickImage();
                          }
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: Dimensions.w(90),
                              height: Dimensions.h(90),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.primaryColor),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.greyColor,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: controller.pickedImage.value == null
                                  ? const Center(
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(controller.pickedImage.value!.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h(30)),

                    // Book Appointment Button
                    HVButton(
                      label: AppStrings.bookAppointment,
                      onPressed: () {
                        if ((provider.services?.isEmpty ?? true)) {
                          AppSnackBar.fail(
                              title: "Error", "No service available");
                          return;
                        }

                        controller.createAppointment(
                          providerId: provider.id!,
                          serviceId: provider.services!.first.id!,
                        );
                      },
                    ),
                    SizedBox(height: Dimensions.h(100)),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
