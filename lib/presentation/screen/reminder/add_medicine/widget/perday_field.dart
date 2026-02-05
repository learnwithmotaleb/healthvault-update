
// lib/widgets/blood_group_field.dart
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/screen/category_screen/details/widget/select_your_service.dart';
import 'package:healthvault/presentation/screen/reminder/add_medicine/widget/perday_services.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../widget/hv_validation.dart';
import 'dosage_services.dart';


class PerDayField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<Map<String, String>>? onSelected;
  final EdgeInsets contentPadding;

  PerDayField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText = "Select Per Day",
    this.validator,
    this.onSelected,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  }) : super(key: key);

  Future<void> _showBloodDropdown(BuildContext context) async {
    final selected = await showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              Text("Select Times Per Day", style: AppTextStyles.title),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: PerDayServices.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE6E6E6)),
                  itemBuilder: (ctx, index) {
                    final item = PerDayServices.items[index];
                    final label = item['label']!;
                    final isSelected = controller.text == label;
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      title: Text(label, style: AppTextStyles.body),
                      trailing: isSelected
                          ? Icon(Icons.check, color: AppColors.primaryColor, size: 20)
                          : null,
                      onTap: () => Navigator.pop(ctx, item),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      controller.text = selected['label']!;
      onSelected?.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: true,                 // prevent keyboard, open dropdown on tap
      onTap: () => _showBloodDropdown(context),
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
        suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.blackColor),
      ),
      validator: validator ?? AppValidators.required(),
    );
  }
}
