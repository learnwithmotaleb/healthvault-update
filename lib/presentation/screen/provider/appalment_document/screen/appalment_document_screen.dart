import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';

import '../../../../../utils/static_strings/static_strings.dart';

class AppalmentDocumentScreen extends StatefulWidget {
  const AppalmentDocumentScreen({super.key});

  @override
  State<AppalmentDocumentScreen> createState() => _AppalmentDocumentScreenState();
}

class _AppalmentDocumentScreenState extends State<AppalmentDocumentScreen> {

  final List<String> images = [
    AppImages.motalebImage,
    AppImages.onboard1,
    AppImages.motalebImage,
    AppImages.onboard3,
    AppImages.motalebImage,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title:AppStrings.details.tr),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h(10),),
            Text(AppStrings.appalmentDocument.tr,style: AppTextStyles.body,),
            SizedBox(height: Dimensions.h(10),),
            SizedBox(
              height: Dimensions.h(200), // adjust height as needed
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(), // optional if you want parent scroll
                padding: EdgeInsets.all(Dimensions.h(5)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Dimensions.h(10),
                  crossAxisSpacing: Dimensions.w(10),
                  childAspectRatio: 95.76 / 63.84,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.r(5)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: Dimensions.w(95.76),
                      height: Dimensions.h(63.84),
                    ),
                  );
                },
              ),
            ),




          ],
        ),
      ),
    );
  }
}
