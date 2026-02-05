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
import '../controller/passport_identification_controller.dart';

class PassportIdentificationScreen extends StatefulWidget {
  const PassportIdentificationScreen({super.key});

  @override
  State<PassportIdentificationScreen> createState() => _PassportIdentificationScreenState();
}

class _PassportIdentificationScreenState extends State<PassportIdentificationScreen> {

  // Initialize controller
  final PassportIdentificationController controller = Get.put(PassportIdentificationController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.identification.tr),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            Text(
              AppStrings.identification.tr,
              style: AppTextStyles.body,
            ),
            SizedBox(height: Dimensions.h(20)),

            // Upload box (100 x 100)
            Obx(
                  () => GestureDetector(
                onTap: () {
                  if (controller.photoForIdentification.value == null) {
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
                      child: controller.photoForIdentification.value == null
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
                          File(controller.photoForIdentification.value!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Close icon (only when photo selected)
                    if (controller.photoForIdentification.value != null)
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
                  controller.registration();
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}
