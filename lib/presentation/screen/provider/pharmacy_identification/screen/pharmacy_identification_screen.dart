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

import '../../../../widget/hv_validation.dart';
import '../controller/pharmacy_identification_controller.dart';
import '../widget/pharmacy_service_field.dart';

class PharmacyIdentificationScreen extends StatefulWidget {
  const PharmacyIdentificationScreen({super.key});

  @override
  State<PharmacyIdentificationScreen> createState() => _PharmacyIdentificationScreenState();
}

class _PharmacyIdentificationScreenState extends State<PharmacyIdentificationScreen> {


  late final PharmacyIdentificationController controller;
  late final DoctorIdentificationController doctorController;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments ?? {};

    controller = Get.put(PharmacyIdentificationController());
    doctorController = Get.put(
      DoctorIdentificationController(args["providerLabel"] ?? ""),
    );
  }

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
              Text(AppStrings.name.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(10),),
              HVTextField(controller: controller.nameController,
              hint: AppStrings.enterName.tr,),
              SizedBox(height: Dimensions.h(16),),
          
              Text(AppStrings.businessRegistrationNumber.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(10),),
              HVTextField(controller: controller.businessRegisterNumberController,
                hint: AppStrings.enterRegistrationNumber.tr,),
              SizedBox(height: Dimensions.h(16),),
              Text(AppStrings.selectService.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(10),),

              DoctorServiceField(
                controller: doctorController.doctorServiceController,
                items: doctorController.serviceList,
                onSelected: (service) {
                  doctorController.selectService(service);
                },
              ),

              SizedBox(height: Dimensions.h(16),),
              SizedBox(height: Dimensions.h(16),),
          
          
              Text(AppStrings.drugLicenseNumber.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(10),),
              HVTextField(controller: controller.drugLicenseNumberController,
                hint: AppStrings.enterCenterInstitutionName.tr,),
              SizedBox(height: Dimensions.h(16),),
          
              Text(AppStrings.address.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(10),),
              HVTextField(controller: controller.addressController,
                hint: AppStrings.enterYourAddress.tr,),
              SizedBox(height: Dimensions.h(16),),
          
          
              Text(AppStrings.about.tr, style: AppTextStyles.label,),
              SizedBox(height: Dimensions.h(10),),
              HVTextField(controller: controller.aboutController,
                hint: AppStrings.enterYourAbout.tr,),
              SizedBox(height: Dimensions.h(40),),
          
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
