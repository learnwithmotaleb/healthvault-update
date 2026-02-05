import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../controller/identification_controller.dart';

class IdentificationScreen extends StatelessWidget {
  IdentificationScreen({super.key});

  // Initialize controller
  final IdentificationController controller = Get.put(IdentificationController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(AppStrings.proofOfIdentification.tr),
        elevation: 0,
      ),
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
            SizedBox(height: Dimensions.h(16)),

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
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                  controller.registration();

                  print("Hello flutter");
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}
