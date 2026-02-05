import 'package:flutter/material.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

class ProfileSectionTitle extends StatelessWidget {
  final String title;

  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTextStyles.title.copyWith(
        fontWeight: FontWeight.normal
      )),
    );
  }
}
