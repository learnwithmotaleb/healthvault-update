import 'package:flutter/material.dart';
import '../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';
import '../../../widget/hv_button.dart';

class EmergencyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback? onPressed;
  final IconData leadingIcon;
  final Color backgroundColor;
  final Color buttonColor;

  const EmergencyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.onPressed,
    required this.leadingIcon,
    required this.backgroundColor,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 175,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: Icon(
                  leadingIcon,
                  color: backgroundColor,
                ),
              ),
              title: Text(
                title,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.whiteColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            SizedBox(height: Dimensions.h(5)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: HVButton(
                label: buttonLabel,
                onPressed: onPressed ?? () {},
                leadingIcon: Icon(Icons.emergency_outlined),
                backgroundColor: buttonColor,
                borderSideColor: buttonColor,
                height: Dimensions.h(42),
                width: Dimensions.h(330),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
