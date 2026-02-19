import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/hv_button.dart';
import '../../../../widget/hv_text_field.dart';
import '../../../../widget/hv_validation.dart';
import '../../../category_screen/details/widget/date_picker_field.dart';
import '../../../category_screen/details/widget/time_picker_filed.dart';
import '../../add_medicine/widget/dosage_field.dart';
import '../../add_medicine/widget/freequency_field.dart';
import '../../add_medicine/widget/instructions_field.dart';
import '../../add_medicine/widget/perday_field.dart';
import '../controller/edit_reminder_controller.dart';

class EditReminderScreen extends StatefulWidget {
  const EditReminderScreen({super.key});

  @override
  State<EditReminderScreen> createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  final EditReminderController controller = Get.put(EditReminderController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.editMedicine.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pill Name
                Text(
                  AppStrings.pillName.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                HVTextField(
                  controller: controller.pillNameController,
                  hint: AppStrings.enterPillName.tr,
                ),
                SizedBox(height: Dimensions.h(12)),

                // Dosage
                Text(
                  AppStrings.dosage.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                DosageServiceField(
                  controller: controller.dosageController,
                  hintText: AppStrings.selectYourService.tr,
                  validator: AppValidators.required(),
                  onSelected: (item) {
                    controller.setDosageServiceGroup(
                      label: item['label']!,
                      code: item['value']!,
                    );
                  },
                ),
                SizedBox(height: Dimensions.h(16)),

                // Schedule
                Text(
                  AppStrings.schedule.tr,
                  style: AppTextStyles.title.copyWith(color: AppColors.primaryColor),
                ),
                SizedBox(height: Dimensions.h(16)),

                // Time Per Day
                Text(
                  AppStrings.selectTimePerDay.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                PerDayField(
                  controller: controller.perDayController,
                  hintText: AppStrings.selectTimePerDay.tr,
                  validator: AppValidators.required(),
                  onSelected: (item) {
                    controller.setPerDayServiceGroup(
                      label: item['label']!,
                      code: item['value']!,
                    );
                  },
                ),
                SizedBox(height: Dimensions.h(12)),

                // Select Time
                Text(
                  AppStrings.selectTime.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                TimePickerField(controller: controller.timeController),
                SizedBox(height: Dimensions.h(12)),

                // Frequency
                Text(
                  AppStrings.frequency.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                FreequencyField(controller: controller.freequencyController),
                SizedBox(height: Dimensions.h(12)),

                // Start Date
                Text(
                  AppStrings.startDate.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                DatePickerField(controller: controller.startDateController),
                SizedBox(height: Dimensions.h(12)),

                // End Date
                Text(
                  AppStrings.endDate.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                DatePickerField(controller: controller.endDateController),
                SizedBox(height: Dimensions.h(12)),

                // Instructions
                Text(
                  AppStrings.additionalInstructions.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                InstructionsField(
                  controller: controller.instructionsController,
                  hintText: AppStrings.selectInstruction.tr,
                ),
                SizedBox(height: Dimensions.h(16)),

                // Assign To
                Text(
                  AppStrings.assignTo.tr,
                  style: AppTextStyles.title.copyWith(color: AppColors.primaryColor),
                ),
                SizedBox(height: Dimensions.h(12)),
                Text(
                  AppStrings.chooseWhoThisMedication.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                HVTextField(
                  controller: controller.medicationController,
                  hint: AppStrings.chooseWhoThisMedication.tr,
                ),
                SizedBox(height: Dimensions.h(30)),


                Obx(() => HVButton(
                  label: controller.isLoading.value ? "" :  "Update Reminder".tr,
                  onPressed: controller.isLoading.value ? null : controller.updateReminder,
                  height: 52,
                  width: double.infinity,
                  child: controller.isLoading.value
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2.5,
                    ),
                  )
                      : null,
                )),

                SizedBox(height: Dimensions.h(100)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
