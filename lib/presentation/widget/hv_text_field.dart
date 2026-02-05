
import 'package:flutter/material.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../utils/app_colors/app_colors.dart';

class HVTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? helper;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool obscure;
  final double? radius;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;

  const HVTextField({
    super.key,
    required this.controller,
     this.label,
    this.hint,
    this.helper,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.obscure = false, this.prefixIcon, this.radius, this.borderColor, this.onTap, this.readOnly = false, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: obscure ? 1 : maxLines,
      obscureText: obscure,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: AppTextStyles.hint,
        helperText: helper,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          )

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            )
        )

      ),
      validator: validator,
    );
  }
}
