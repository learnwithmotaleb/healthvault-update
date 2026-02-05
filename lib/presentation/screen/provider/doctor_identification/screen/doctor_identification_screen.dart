import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/presentation/screen/profile/favourite_profile/widget/favourite_card_widget.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/controller/doctor_indentification_controller.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/widget/doctor_service_field.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../widget/hv_validation.dart';

class DoctorIdentificationScreen extends StatefulWidget {
  const DoctorIdentificationScreen({super.key});

  @override
  State<DoctorIdentificationScreen> createState() => _DoctorIdentificationScreenState();
}

class _DoctorIdentificationScreenState extends State<DoctorIdentificationScreen> {

  DoctorIdentificationController controller = Get.put(DoctorIdentificationController(

   Get.arguments["providerLabel"]

  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppStrings.identification.tr),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.h(5),),
              Text(AppStrings.specialisations.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              HVTextField(controller: controller.specialisationsController,
              hint: AppStrings.enterYourSpecialisations.tr,),
              SizedBox(height: Dimensions.h(16),),
          
              Text(AppStrings.idOrPassPortNumber.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              HVTextField(controller: controller.idOrPassPortNumberController,
                hint: AppStrings.enterIdOrPassPortNumber.tr,),
              SizedBox(height: Dimensions.h(16),),
          
          
              Text(AppStrings.medicalLicenseNumber.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              HVTextField(controller: controller.medicalLicenseNumberController,
                hint: AppStrings.enterMedicalLicenseNumber.tr,),
              SizedBox(height: Dimensions.h(16),),
              Text(AppStrings.selectService.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              DoctorServiceField(
                controller: controller.doctorServiceController,
                items: controller.serviceList,
                onSelected: (service) {
                  controller.selectService(service);
                },
              ),

              SizedBox(height: Dimensions.h(16),),
          
          
              Text(AppStrings.yearOfExperience.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              HVTextField(controller: controller.yearOfExperienceController,
                hint: AppStrings.enterYearOfExperience.tr,),
              SizedBox(height: Dimensions.h(16),),
          
              Text(AppStrings.languagesSpoken.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              HVTextField(controller: controller.languagesSpokenController,
                hint: AppStrings.enterLanguagesSpoken.tr,),
              SizedBox(height: Dimensions.h(16),),
          
              Text(AppStrings.address.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              HVTextField(controller: controller.addressController,
                hint: AppStrings.enterYourAddress.tr,),
              SizedBox(height: Dimensions.h(16),),
          
          
              Text(AppStrings.about.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(8),),
              HVTextField(controller: controller.aboutController,
                hint: AppStrings.enterYourAbout.tr,),
              SizedBox(height: Dimensions.h(24),),
          
              HVButton(label: AppStrings.continueButton.tr, onPressed: (){

                Get.toNamed(RoutePath.medicalLicense);

              }),

              SizedBox(height: Dimensions.h(30),),
          
          
          
          
          
          
          
          
            ],
          ),
        ),
      ),

    );
  }
}
