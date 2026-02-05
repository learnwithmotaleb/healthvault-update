import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../category_screen/details/widget/add_document_widget.dart';
import '../controller/medical_license_controller.dart';

class MedicalLicenseScreen extends StatefulWidget {
  const MedicalLicenseScreen({super.key});

  @override
  State<MedicalLicenseScreen> createState() => _MedicalLicenseScreenState();
}

class _MedicalLicenseScreenState extends State<MedicalLicenseScreen> {
  // Initialize controller
  final MedicalLicenseController controller = Get.put(MedicalLicenseController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.profile.tr),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            Text(
              AppStrings.uploadProfilePhoto.tr,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: Dimensions.h(20)),

            // Upload box (100 x 100)
            Obx(
                  () => GestureDetector(
                onTap: () {
                  if (controller.photo.value == null) {
                    controller.pickFromGallery();
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Dimensions.w(100),
                      height: Dimensions.h(100),
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
                      child: controller.photo.value == null
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
                          File(controller.photo.value!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Close icon (only when photo selected)
                    if (controller.photo.value != null)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: GestureDetector(
                          onTap: controller.removePhoto,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935), // red
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(100)),

            Obx(
                  () => HVButton(
                label: controller.isLoading.value ? "Please wait..." : AppStrings.next.tr,
                onPressed: (){
                  Get.toNamed(RoutePath.passportPhoto);
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}
