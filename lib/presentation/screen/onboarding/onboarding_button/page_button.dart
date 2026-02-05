import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../core/responsive_layout/dimensions/dimensions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
  });

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
              image: AssetImage(image,),
            fit: BoxFit.cover,
      
          ),
          SizedBox(height: Dimensions.h(150)),
      
      
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
              textAlign: TextAlign.center,
            ),
          ),
      
        ],
      ),
    );
  }
}