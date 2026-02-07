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
import '../../../../../core/routes/route_path.dart';
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
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    /// ----------------- Profile Image -----------------
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.r(56),
                          backgroundColor: AppColors.primaryColor,
                          backgroundImage: controller.pickedImage.value != null
                              ? FileImage(controller.pickedImage.value!)
                              : AssetImage(AppImages.motalebImage)
                          as ImageProvider,
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
                                  )
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
                    ),

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
                            hint: "Abdul Motaleb",
                            validator: AppValidators.required(),
                          ),
                          SizedBox(height: Dimensions.h(16)),

                          Text(AppStrings.contactNumber.tr,
                              style: AppTextStyles.body),
                          const SizedBox(height: 8),
                          HVTextField(
                            controller: controller.numberController,
                            hint: "+8801701577479",
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

                          )
,
                          SizedBox(height: Dimensions.h(16)),

                          Text(AppStrings.gender.tr,
                              style: AppTextStyles.body),
                          const SizedBox(height: 8),
                          HVTextField(
                            controller: controller.genderController,
                            validator: AppValidators.required(),
                            hint: "Male",
                          ),

                          SizedBox(height: Dimensions.h(30)),
                        ],
                      ),
                    ),

                    controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : HVButton(
                      label: AppStrings.update,
                      onPressed: () async {
                        controller.updateProfile();
                      },
                    ),


                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
