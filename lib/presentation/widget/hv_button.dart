import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';

class HVButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  final Color? borderSideColor;
  final double borderRadius;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? child; // ✅ added

  const HVButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.height = 50,
    this.width = double.infinity,
    this.borderRadius = 10,
    this.leadingIcon,
    this.trailingIcon,
    this.borderSideColor = AppColors.primaryColor,
    this.child, // ✅ added
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed == null
              ? AppColors.greyColor
              : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSideColor != null
                ? BorderSide(color: borderSideColor!, width: 1.0)
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        // ✅ if child provided, show it; otherwise show default label row
        child: child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leadingIcon != null) ...[
                  leadingIcon!,
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(color: textColor, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailingIcon != null) ...[
                  const SizedBox(width: 8),
                  trailingIcon!,
                ],
              ],
            ),
      ),
    );
  }
}