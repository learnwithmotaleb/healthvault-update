import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/presentation/screen/category_screen/details/widget/date_picker_field.dart';
import 'package:healthvault/presentation/screen/user/auth/registaration/controller/registration_controller.dart';
import 'package:healthvault/presentation/widget/hv_validation.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/hv_button.dart';
import '../widget/blood_groupField.dart';
import '../widget/gender_textfiled.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final controller = Get.put(RegistrationController());



  static const List<Map<String, String>> items = [
    {'label': 'A+',  'value': 'A_pos'},
    {'label': 'A-',  'value': 'A_neg'},
    {'label': 'B+',  'value': 'B_pos'},
    {'label': 'B-',  'value': 'B_neg'},
    {'label': 'AB+', 'value': 'AB_pos'},
    {'label': 'AB-', 'value': 'AB_neg'},
    {'label': 'O+',  'value': 'O_pos'},
    {'label': 'O-',  'value': 'O_neg'},
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title:  Text(AppStrings.registration.tr),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.personalInformation.tr,
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.normal
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: 12,),

            /// Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.fullName.tr,   style: AppTextStyles.label),
                    SizedBox(height: Dimensions.h(10)),

                    TextFormField(
                      controller: controller.fullNameController,
                      focusNode: controller.fullNameFocus,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.hint,
                        hintText: AppStrings.enterYourName.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                      validator: AppValidators.required()
                    ),
                    const SizedBox(height: 20),

                    Text(AppStrings.dateOfBirth.tr,   style: AppTextStyles.label.copyWith(

                    )
                    ),
                    const SizedBox(height: 16),
                    // TextFormField(
                    //   controller: controller.dateOfBirthController,
                    //   focusNode: controller.dateOfBirthFocus,
                    //   keyboardType: TextInputType.datetime,
                    //   decoration: InputDecoration(
                    //     hintStyle:AppTextStyles.hint,
                    //     hintText: AppStrings.enterYourDateOfBirth.tr,
                    //     contentPadding: const EdgeInsets.symmetric(
                    //       horizontal: 16,
                    //       vertical: 14,
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(6),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(6),
                    //       borderSide:
                    //       BorderSide(color: AppColors.primaryColor),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(6),
                    //       borderSide:
                    //       BorderSide(color: AppColors.primaryColor),
                    //     ),
                    //   ),
                    //   validator: AppValidators.required()
                    // ),
                    DatePickerField(controller: controller.dateOfBirthController,
                      hintText: AppStrings.enterYourDateOfBirth.tr,
                      focusNode: controller.dateOfBirthFocus,

                    ),
                    const SizedBox(height: 20),
                    Text(AppStrings.gender.tr,   style: AppTextStyles.label),
                    const SizedBox(height: 14),

                    GenderField(
                      controller: controller.genderController,
                      focusNode: controller.genderFocus,
                      hintText: AppStrings.selectYourGender.tr,
                      validator: AppValidators.required(),
                      onSelected: (item) {
                        // item['label'] => e.g., "Male"
                        // item['value'] => e.g., "male"
                        // Store internally if needed:
                        // controller.selectedGenderCode.value = item['value']!;
                      },
                    ),

                    SizedBox(height: Dimensions.h(20)),


                    Text(AppStrings.bloodGroup.tr,   style: AppTextStyles.label

                    ),
                    SizedBox(height: 16),



                    BloodGroupField(
                      controller: controller.bloodGroupController,
                      focusNode: controller.bloodGroupFocus,
                      hintText: AppStrings.selectYourBloodGroup.tr,
                      validator: AppValidators.required(),
                      onSelected: (item) {
                        controller.setBloodGroup(
                          label: item['label']!,
                          code: item['value']!,
                        );
                      },
                    ),



                    const SizedBox(height: 20),
                    /// Confirm Password
                    Text(AppStrings.membershipID.tr,  style: AppTextStyles.label),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.membershipIDController,
                      focusNode: controller.membershipIDFocus,
                      decoration: InputDecoration(
                        hintStyle:AppTextStyles.hint,
                        hintText: AppStrings.enterYourMembershipId.tr,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),    focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),

                      ),
                      validator: AppValidators.required()

                    ),
                    const SizedBox(height: 20),

                    Text(AppStrings.emergencyContact.tr,  style: AppTextStyles.label),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.emergencyContactController,
                      focusNode: controller.emergencyFocus,
                      decoration: InputDecoration(
                        hintStyle:AppTextStyles.hint,
                        hintText: AppStrings.enterYouEmergencyContact.tr,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),

                      ),
                      validator: AppValidators.required()

                    ),
                    const SizedBox(height: 20),
                    Text(AppStrings.identification.tr,  style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Text(AppStrings.nationalIdOrPassportNumber.tr,  style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.normal
                    )),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.identificationController,
                      focusNode: controller.identificationFocus,
                      decoration: InputDecoration(
                        hintStyle:AppTextStyles.hint,
                        hintText: AppStrings.nationalIdNumbererOrPassportNumber.tr,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          BorderSide(color: AppColors.primaryColor),
                        ),

                      ),
                      validator: AppValidators.required()

                    ),
                    const SizedBox(height: 20),

                    Text(AppStrings.address.tr,  style: AppTextStyles.label.copyWith(
                        fontWeight: FontWeight.normal
                    )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: controller.addressController,
                        focusNode: controller.addressFocus,
                        decoration: InputDecoration(
                          hintStyle:AppTextStyles.hint,
                          hintText: AppStrings.enterYourAddress.tr,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: AppColors.primaryColor),
                          ),

                        ),
                        validator: AppValidators.required()

                    ),
                    const SizedBox(height: 50),


                    /// Login Button
                    HVButton(
                      label: AppStrings.next.tr,
                      onPressed: (){

                        Get.toNamed(RoutePath.identification);


                      },
                      height: 52,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 100),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
