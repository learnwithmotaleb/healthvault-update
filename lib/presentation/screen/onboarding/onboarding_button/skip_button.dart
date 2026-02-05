
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../controller/onboarding_controller.dart';


class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 30,
        right: 10,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child:  Text(AppStrings.skip.tr,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            color: AppColors.primaryColor
          ),),
        ));
  }
}