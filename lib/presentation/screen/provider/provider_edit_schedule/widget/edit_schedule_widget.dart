import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/hv_button.dart';
import '../../../category_screen/details/widget/time_picker_filed.dart';
import '../controller/provider_edit_schedule_controller.dart';

class EditScheduleBottomSheet extends StatelessWidget {
  EditScheduleBottomSheet({super.key});

  final controller = Get.put(ProviderEditScheduleController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.editSchedule.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// ---------------- Day Dropdown ----------------
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: AppStrings.days.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
            items: const [
              DropdownMenuItem(value: "MON", child: Text("MONDAY")),
              DropdownMenuItem(value: "TUE", child: Text("TUESDAY")),
              DropdownMenuItem(value: "WED", child: Text("WEDNESDAY")),
              DropdownMenuItem(value: "THU", child: Text("THURSDAY")),
              DropdownMenuItem(value: "FRI", child: Text("FRIDAY")),
              DropdownMenuItem(value: "SAT", child: Text("SATURDAY")),
              DropdownMenuItem(value: "SUN", child: Text("SUNDAY")),
            ],
            onChanged: (value) {
              controller.selectedDay.value = value ?? "";
            },
          ),

          const SizedBox(height: 16),

          TimePickerField(
            hintText: AppStrings.startTime.tr,
            controller: controller.startTime,
          ),

          const SizedBox(height: 16),

          TimePickerField(
            hintText: AppStrings.endTime.tr,
            controller: controller.endTime,
          ),

          const SizedBox(height: 20),

          /// ---------------- Submit Button ----------------
          HVButton(
            label: AppStrings.continueButton.tr,
            onPressed: () {
              controller.submitSchedule();
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
