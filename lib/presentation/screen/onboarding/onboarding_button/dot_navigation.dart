
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../controller/onboarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
        bottom: 20,
        left:20,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked:controller.dotNavigationClick,
          count: 3,

          effect:  const ExpandingDotsEffect(
              dotColor: AppColors.greyColor,
              activeDotColor:AppColors.primaryColor, dotHeight: 6),
        )
    );
  }
}