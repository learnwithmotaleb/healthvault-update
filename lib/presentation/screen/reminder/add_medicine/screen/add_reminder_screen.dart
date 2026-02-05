import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/screen/category_screen/details/widget/time_picker_filed.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/hv_validation.dart';
import '../../../category_screen/details/widget/date_picker_field.dart';
import '../controller/add_reminder_controller.dart';
import '../widget/dosage_field.dart';
import '../widget/freequency_field.dart';
import '../widget/instructions_field.dart';
import '../widget/perday_field.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  AddReminderController controller = Get.put(AddReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.addMedicine.tr),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.pillName.tr,
                  style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                HVTextField(
                  controller: controller.pillNameController,
                  hint: AppStrings.enterPillName.tr,
                  validator: AppValidators.required(),
                ),
                SizedBox(height: Dimensions.h(12)),
                Text(AppStrings.dosage.tr, style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
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
                Text(
                  AppStrings.schedule.tr,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: Dimensions.h(16)),
                Text(AppStrings.selectTimePerDay.tr, style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
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
                Text(AppStrings.selectTime.tr,style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                Column(
                  children: [
                    Obx(() => Column(
                      children: List.generate(controller.timeControllers.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.h(10)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TimePickerField(
                                  controller: controller.timeControllers[index],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.addTimeField();
                                },
                                icon: Icon(
                                  Icons.add_circle_outline_outlined,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              if (controller.timeControllers.length > 1)
                                IconButton(
                                  onPressed: () {
                                    controller.removeTimeField(index);
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline_outlined,
                                    color: AppColors.readColor,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    )),
                  ],
                ),

                SizedBox(height: Dimensions.h(12)),
                Text(AppStrings.frequency.tr, style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                FreequencyField(controller: controller.freequencyController),
                SizedBox(height: Dimensions.h(12)),

                Text(AppStrings.startDate.tr, style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),

                DatePickerField(controller: controller.startDateController),
                SizedBox(height: Dimensions.h(12)),

                Text(AppStrings.endDate.tr,style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),

                DatePickerField(controller: controller.endDateController),
                SizedBox(height: Dimensions.h(12)),
                Text(AppStrings.additionalInstructions.tr,style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),

                InstructionsField(controller: controller.instructionsController,
                hintText: AppStrings.selectInstruction.tr,),
                SizedBox(height: Dimensions.h(16)),

                Text(
                 AppStrings.assignTo.tr,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: Dimensions.h(12)),
                Text(AppStrings.chooseWhoThisMedication.tr, style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: Dimensions.h(10)),
                HVTextField(
                  controller: controller.medicationController,
                  hint: AppStrings.chooseWhoThisMedication.tr,
                  validator: AppValidators.required(),
                ),

                SizedBox(height: Dimensions.h(30)),
                HVButton(label: AppStrings.add.tr, onPressed: () {

                  controller.addReminder();


                }),

                SizedBox(height: Dimensions.h(100)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
