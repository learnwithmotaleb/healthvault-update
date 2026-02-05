
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';

import '../controller/onboarding_controller.dart';


class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
        right: 5,
        bottom: 10,
        child: ElevatedButton(
          onPressed: ()=> OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(shape: const CircleBorder(


          ),
              backgroundColor: AppColors.primaryColor),
          child: const Icon(Icons.arrow_forward,size: 20,fontWeight: FontWeight.bold,),
        ));
  }
}