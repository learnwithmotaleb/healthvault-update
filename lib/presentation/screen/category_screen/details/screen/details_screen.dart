import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/presentation/screen/category_screen/details/widget/select_your_service_field.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';
import 'package:healthvault/service/api_url.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import 'package:http/http.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_alert.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/hv_validation.dart';
import '../controller/details_controller.dart';
import '../widget/add_document_widget.dart';
import '../widget/availability_section.dart';
import '../widget/bullet_price_row_widget.dart';
import '../widget/date_picker_field.dart';
import '../widget/time_picker_filed.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsController controller = Get.put(DetailsController());
  @override
  Widget build(BuildContext context) {


    final providerImage = controller.provider["profile_image"] != null
        ? ApiUrl.buildImageUrl(controller.provider["profile_image"] )
        : AppImages.onboard3;


    print(providerImage);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.details.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:
                        controller.provider['profile_image'] != null &&
                            controller.provider['profile_image']
                                .toString()
                                .isNotEmpty
                        ? Image.network(
                          providerImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // fallback if network fails
                              return Image.asset(
                                AppImages.motalebImage,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            AppImages.motalebImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),

                  SizedBox(width: Dimensions.w(30)), // reduce gap

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.provider['fullName'] ??
                                "Unknown Provider",
                            style: AppTextStyles.title,
                          ),
                        ],
                      ),

                      Text(
                        controller.provider['specialization'] ??
                            "No specialization",
                        style: AppTextStyles.body,
                      ),
                      SizedBox(height: 2),
                      Text(
                        controller.provider['contactNumber'] ?? "+880000000000",
                        style: AppTextStyles.body,
                      ),
                      SizedBox(height: 2),
                      Text(
                        controller.provider['email'] ?? "user@example.com",
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: Dimensions.h(20)),
              Text(
                AppStrings.about.tr,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),

              SizedBox(height: Dimensions.h(10)),
              Text(
                controller.provider['about'] ?? "No about information",
                style: AppTextStyles.body,
              ),
              SizedBox(height: Dimensions.h(20)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.service.tr,
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(AppStrings.seeMore.tr, style: AppTextStyles.hint),
                ],
              ),

              SizedBox(height: Dimensions.h(20)),
              if (controller.service.isNotEmpty)
                BulletPriceRow(
                  title: controller.service['title'] ?? "N/A",
                  price: "\$${controller.service['price'] ?? "0"}",
                ),
              BulletPriceRow(
                title: controller.service['title'] ?? "N/A",
                price: "\$${controller.service['price'] ?? "0"}",
              ),
              BulletPriceRow(
                title: controller.service['title'] ?? "N/A",
                price: "\$${controller.service['price'] ?? "0"}",
              ),

              SizedBox(height: Dimensions.h(10)),

              /// ---------------- Appointment Info ----------------
              Text(AppStrings.bookingDate.tr, style: AppTextStyles.label),
              SizedBox(height: Dimensions.h(5)),
              Text(
                controller.appointment['appointmentDateTime'] ?? "N/A",
                style: AppTextStyles.body,
              ),
              SizedBox(height: Dimensions.h(10)),
              Text(AppStrings.bookAppointment.tr, style: AppTextStyles.label),
              SizedBox(height: Dimensions.h(5)),
              Text(
                controller.appointment['status'] ?? "No Status",
                style: AppTextStyles.body,
              ),

              SizedBox(height: Dimensions.h(30)),

              AvailabilitySection(
                title: AppStrings.availability.tr,
                icon: Icons.calendar_month,
                items: [
                  {
                    "day": "Sunday",
                    "time": "10:00 AM - 1:00 PM\n10:00 AM - 1:00 PM",
                  },
                  {
                    "day": "Monday",
                    "time": "2:00 PM - 5:00 PM\n10:00 AM - 1:00 PM",
                  },
                  {
                    "day": "Tuesday",
                    "time": "6:00 PM - 9:00 PM\n10:00 AM - 1:00 PM",
                  },
                  {
                    "day": "Wednesday",
                    "time": "9:00 AM - 12:00 PM\n10:00 AM - 1:00 PM",
                  },
                ],
              ),
              // SizedBox(height: Dimensions.h(20)),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       AppStrings.reasonForVisit.tr,
              //       style: AppTextStyles.label,
              //     ),
              //     SizedBox(height: Dimensions.h(10)),
              //     HVTextField(
              //       controller: controller.reasonController,
              //       hint: AppStrings.writeHere,
              //     ),
              //     SizedBox(height: Dimensions.h(10)),
              //     Text(
              //       AppStrings.selectYourService.tr,
              //       style: AppTextStyles.label,
              //     ),
              //     SizedBox(height: Dimensions.h(10)),
              //
              //     SelectYourServiceField(
              //       controller: controller.selectServiceController,
              //       hintText: AppStrings.selectYourService.tr,
              //       validator: AppValidators.required(),
              //       onSelected: (item) {
              //         controller.setServiceGroup(
              //           label: item['label']!,
              //           code: item['value']!,
              //         );
              //       },
              //     ),
              //     SizedBox(height: Dimensions.h(10)),
              //
              //     Text(
              //       AppStrings.selectYourDate.tr,
              //       style: AppTextStyles.label,
              //     ),
              //     SizedBox(height: Dimensions.h(10)),
              //     DatePickerField(
              //       controller: controller.selectYourDateController,
              //       hintText: AppStrings.selectAppointmentDate.tr,
              //       onDateSelected: (date) {
              //         print("Selected date: $date");
              //       },
              //       validator: AppValidators.required(),
              //     ),
              //
              //     SizedBox(height: Dimensions.h(10)),
              //
              //     Text(
              //       AppStrings.selectYourTime.tr,
              //       style: AppTextStyles.label,
              //     ),
              //     SizedBox(height: Dimensions.h(10)),
              //     TimePickerField(
              //       controller: controller.selectTimeController,
              //       hintText: AppStrings.selectAppointmentTime.tr,
              //       onTimeSelected: (time) {
              //         print("Selected time: ${time.format(context)}");
              //       },
              //       validator: AppValidators.required(),
              //     ),
              //
              //     SizedBox(height: Dimensions.h(30)),
              //
              //     Text(AppStrings.addDocument.tr, style: AppTextStyles.label),
              //     SizedBox(height: Dimensions.h(30)),
              //     DocumentPickerField(
              //       boxSize: 100, // optional
              //       maxImages: 5, // optional
              //       onChanged: (images) {
              //         print("Selected images: ${images.length}");
              //       },
              //     ),
              //     SizedBox(height: Dimensions.h(30)),
              //     HVButton(
              //       label: AppStrings.bookAppointment,
              //
              //       onPressed: () => _showAlert(context),
              //     ),
              //     SizedBox(height: Dimensions.h(100)),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
