import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../helper/date_time_converter/date_time_converter.dart';
import '../../../../../utils/app_colors/app_colors.dart';


class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String scheduleDate;
  final String scheduleText;
  final String bookingDate;
  final String time;
  final String location;
  final String reason;

  const ServiceCard({
    Key? key,
    required this.serviceName,
    required this.scheduleDate,
    required this.scheduleText,
    required this.bookingDate,
    required this.time,
    required this.location,
    required this.reason,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.h(10)),
      margin: EdgeInsets.symmetric(vertical: Dimensions.h(10)),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.r(15)),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Name
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  AppStrings.serviceName.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  serviceName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h(10)),

          // Schedule
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(scheduleDate,style: AppTextStyles.body.copyWith(
    color: AppColors.blackColor)),
              Text(scheduleText),
            ],
          ),
          SizedBox(height: Dimensions.h(5)),

          // Booking Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.bookingDate.tr,style: AppTextStyles.body.copyWith(
                color: AppColors.blackColor
              ),),
              // Text(bookingDate),
              Text(DateTimeHelper.time(bookingDate))
            ],
          ),
          SizedBox(height: Dimensions.h(5)),

          // Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(scheduleDate,style: AppTextStyles.body,),
              Text(DateTimeHelper.time(time))

    ],
          ),
          SizedBox(height: Dimensions.h(10)),

          // Location
          Text(
          AppStrings.location.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(location),
          SizedBox(height: Dimensions.h(10)),

          // Reason
          Text(
           AppStrings.reasonForVisit.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(reason),
        ],
      ),
    );
  }
}
