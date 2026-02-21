import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/screen/category_screen/details/widget/date_picker_field.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';
import 'package:healthvault/presentation/widget/hv_validation.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.editProfile.tr),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() {

          // ✅ Show full screen loader while loading existing profile
          if (controller.isLoading.value &&
              controller.nameController.text.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.h(10)),

                    /// ----------------- Profile Image -----------------
                    // ✅ Replace the image Stack with this
                    Obx(() {
                      return Stack(
                        children: [
                          CircleAvatar(
                            radius: Dimensions.r(56),
                            backgroundColor: AppColors.primaryColor,
                            backgroundImage: _resolveImage(controller),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: controller.pickImage,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 1,
                                      color: AppColors.blackColor,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    SizedBox(height: Dimensions.h(20)),

                    /// ----------------- Form Fields -----------------
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.name.tr, style: AppTextStyles.body),
                          const SizedBox(height: 8),
                          HVTextField(
                            controller: controller.nameController,
                            hint: "Your Name",
                            validator: AppValidators.required(),
                          ),
                          SizedBox(height: Dimensions.h(16)),

                          Text(AppStrings.contactNumber.tr,
                              style: AppTextStyles.body),
                          const SizedBox(height: 8),
                          HVTextField(
                            controller: controller.numberController,
                            hint: "+0123456789",
                            keyboardType: TextInputType.phone,
                            validator: AppValidators.required(),
                          ),
                          SizedBox(height: Dimensions.h(16)),

                          Text(AppStrings.dateOfBirth.tr,
                              style: AppTextStyles.body),
                          const SizedBox(height: 8),
                          DatePickerField(
                            controller: controller.dateOfBirthController,
                            hintText: "Select Date Of Birth",
                            validator: AppValidators.required(),
                          ),
                          SizedBox(height: Dimensions.h(16)),

                          Text(AppStrings.gender.tr,
                              style: AppTextStyles.body),
                          const SizedBox(height: 8),
                          HVTextField(
                            controller: controller.genderController,
                            validator: AppValidators.required(),
                            hint: "MALE / FEMALE",
                          ),

                          SizedBox(height: Dimensions.h(30)),
                        ],
                      ),
                    ),

                    // ✅ Show loader only on submit, not full screen
                    controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : HVButton(
                      label: AppStrings.update,
                      onPressed: () => controller.updateProfile(),
                    ),

                    SizedBox(height: Dimensions.h(30)),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ✅ Resolve correct image source in priority order
  ImageProvider _resolveImage(EditProfileController controller) {
    if (controller.pickedImage.value != null) {
      return FileImage(controller.pickedImage.value!);
    } else if (controller.existingImageUrl.value.isNotEmpty) {
      return NetworkImage(controller.existingImageUrl.value);
    } else {
      return AssetImage(AppImages.motalebImage);
    }
  }
}