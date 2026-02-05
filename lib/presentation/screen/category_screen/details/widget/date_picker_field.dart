import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../widget/hv_validation.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<DateTime>? onDateSelected;
  final EdgeInsets contentPadding;

  const DatePickerField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText = "Select Date",
    this.validator,
    this.onDateSelected,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  }) : super(key: key);

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controller.text = formattedDate;
      if (onDateSelected != null) {
        onDateSelected!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: true,
      onTap: () => _pickDate(context),
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
        suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
      ),
      validator: validator ?? AppValidators.required(),
    );
  }
}
