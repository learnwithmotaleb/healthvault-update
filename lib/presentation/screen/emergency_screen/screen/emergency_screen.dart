import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/google_map_widget.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {


  Future<void> openDialPad(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch dial pad';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: Dimensions.h(180),
            decoration: BoxDecoration(
              color: AppColors.emergencyColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_sharp,
                        color: AppColors.whiteColor,
                        size: 20,),
                        onPressed: (){
                          Get.back();
                        },
                      ),
                      SizedBox(width: Dimensions.w(20)),
                      Image.asset(
                        AppImages.ambulance,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(width: Dimensions.w(20)),
                      Text(
                        AppStrings.requestEmergency.tr,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h(10)),
                  Text(
                   AppStrings.directConnectionToEmergencyService.tr,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height:Dimensions.h(200),
              
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8E1E1), // Light pink background
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ), // Red border
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HVButton(
                            onPressed: () {
                              openDialPad("999");
                            },
                            leadingIcon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            label: AppStrings.requestEmergency.tr,
                            borderSideColor: AppColors.whiteColor,
                            backgroundColor: AppColors.emergencyColor,
                            borderRadius: 8,
                            width: Dimensions.w(300),
                            height: Dimensions.w(55),
                          ),
              
                          SizedBox(height: Dimensions.h(12)),
              
                          Text(
                            AppStrings.anAmbulanceTeamWillCallYouImmediately.tr,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.emergencyColor
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: AppColors.emergencyColor,
                          size: 20,
                        ),
                        SizedBox(width: Dimensions.w(6)),
              
                        Text(
                         AppStrings.yourLocation.tr,
                          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: Dimensions.h(10)),
              
                  // Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                           AppStrings.locationFound.tr,
                             style: AppTextStyles.body.copyWith(fontSize: 18),
                          ),
                           SizedBox(height: Dimensions.h(4)),
                          Text(
                            "Eleftheriou Venizelou, Agia Eleousa, 2nd Community of Kallithea, Municipality of Kallithea Regional Unit of South Athens, Region of Attica,Decentralized Administration of Attica, 17675, Greece",
                            style: AppTextStyles.body
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(children: [CurrentLocationMap()]),

                  SizedBox(height: Dimensions.h(20)),






                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
