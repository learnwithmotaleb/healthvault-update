import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../appointment/widget/appointment_card.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({super.key});

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {

  final List<Map<String, String>> appointmentList = [
    {
      'doctorName': 'Dr. Alisha Lehmann',
      'service': 'X-Ray',
      'price': '\$50',
      'dateTime': '23 Nov 11:PM',
      'status': 'Requested',
    },
    {
      'doctorName': 'Dr. John Smith',
      'service': 'MRI',
      'price': '\$120',
      'dateTime': '24 Nov 10:AM',
      'status': 'Requested',
    },
    {
      'doctorName': 'Dr. Emily Rose',
      'service': 'Blood Test',
      'price': '\$30',
      'dateTime': '25 Nov 2:PM',
      'status': 'Requested',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            height: Dimensions.h(155),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: Dimensions.w(24),
                      backgroundImage: AssetImage(AppImages.motalebImage),
                    ),
                    title: Text(
                      "Abdul Motaleb",
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      AppStrings.welcomeBack.tr,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.whiteColor.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutePath.notification);
                      },
                      child: Container(
                        width: Dimensions.w(40),
                        height: Dimensions.w(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.whiteColor.withOpacity(0.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: Dimensions.h(20)),

          // Total Appointments Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
            child: Container(
              width:  Dimensions.w(309),
              height: Dimensions.h(121),
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.h(16),
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.providerSelectionColor,
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "6400",
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.providerSelectionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: Dimensions.h(4)),
                    Text(
                      "Total",
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.providerSelectionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: Dimensions.h(4)),
                    Text(
                      AppStrings.appointmentRequest.tr,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.providerSelectionColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: Dimensions.h(24)),


          // Recent Appointments Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
               AppStrings.recentAppointments.tr,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.providerHomePageColor,
                ),
              ),
            ),
          ),


          // Appointment List
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(0)),
              child: ListView.separated(
                itemCount: appointmentList.length,
                separatorBuilder: (_, __) => SizedBox(height: Dimensions.h(5)),
                itemBuilder: (context, index) {
                  final appointment = appointmentList[index];
                  return AppointmentCard(
                    doctorName: appointment['doctorName']!,
                    service: appointment['service']!,
                    price: appointment['price']!,
                    dateTime: appointment['dateTime']!,
                    status: appointment['status']!,
                    onTap: () {
                      Get.toNamed(RoutePath.providerDetails);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
