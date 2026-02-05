import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/presentation/screen/profile/favourite_profile/widget/favourite_card_widget.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../widget/provider_detalis_service_card.dart';

class ProviderDetailsScreen extends StatefulWidget {
  const ProviderDetailsScreen({super.key});

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.details.tr),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(

          children: [
            SizedBox(height: Dimensions.h(5),),
            Container(
              width: Dimensions.w(400),
              height:Dimensions.h(136) ,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1

                  )
                ]
              ),
              child:Padding(
                padding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),

                        child: Image.asset(
                          width: Dimensions.w(92),
                          height: Dimensions.h(92),
                            AppImages.motalebImage),
                      ),
                      SizedBox(width: Dimensions.w(24)),
                      // Spacer(),
                      Text("Abdul Motaleb",style: AppTextStyles.title,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.h(16),),
            ServiceCard(
              serviceName: "General Physician, Lab Test",
              scheduleDate: "15 November 2025",
              scheduleText: "Scheduled",
              bookingDate: "20 November 2025",
              time: "06:30 PM",
              location: "Dhaka-Airport, 1230, Dhaka",
              reason: "Annual check-up",
            ),

            SizedBox(height: Dimensions.h(30),),
            HVButton(label: AppStrings.viewDocument.tr,backgroundColor: AppColors.whiteColor,borderSideColor: AppColors.whiteColor, textColor: AppColors.primaryColor,  onPressed: (){

              Get.toNamed(RoutePath.appalmentDocument);
            })

          ],
        ),
      ),
    );
  }
}
