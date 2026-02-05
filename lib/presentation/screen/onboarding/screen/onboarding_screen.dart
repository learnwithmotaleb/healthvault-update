
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import 'package:http/http.dart';

import '../controller/onboarding_controller.dart';
import '../onboarding_button/dot_navigation.dart';
import '../onboarding_button/next_button.dart';
import '../onboarding_button/page_button.dart';
import '../onboarding_button/skip_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:  [
              OnBoardingPage(
                image: AppImages.onboard1,
                title: AppStrings.findALotOFSpecialistDoctor.tr,
              ),
              OnBoardingPage(
                image: AppImages.onboard2,
                title: AppStrings.caringForYourHealthEveryStepOfTheWay.tr,
              ),
              OnBoardingPage(
                  image: AppImages.onboard3,
                  title: AppStrings.moreThenMedicine.tr,
              ),
            ],
          ),
          //skip Button
          const OnBoardingSkip(),

          //Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          //Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
