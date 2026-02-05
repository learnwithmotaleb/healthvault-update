import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../widget/hv_validation.dart';

class TimePickerField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final EdgeInsets contentPadding;

  const TimePickerField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText = "Select Time",
    this.validator,
    this.onTimeSelected,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  }) : super(key: key);

  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context); // e.g., 2:30 PM
      controller.text = formattedTime;
      if (onTimeSelected != null) {
        onTimeSelected!(pickedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: true,
      onTap: () => _pickTime(context),
      decoration: InputDecoration(
        hintStyle: AppTextStyles.hint,
        hintText: hintText,
        contentPadding: contentPadding,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        suffixIcon: const Icon(Icons.access_time, color: AppColors.primaryColor),
      ),
      validator: validator ?? AppValidators.required(),
    );
  }
}
