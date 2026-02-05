import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:healthvault/presentation/screen/category_screen/details/widget/date_picker_field.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/hv_text_field.dart';
import '../../../../widget/hv_validation.dart';

class InsuranceBottomSheet<T extends GetxController> extends StatelessWidget {
  final T controller;

  final TextEditingController nameCtrl;
  final TextEditingController numberCtrl;
  final TextEditingController providerCtrl;
  final TextEditingController dateCtrl;

  final VoidCallback onUpload;
  final VoidCallback onSubmit;
  final bool isEdit;

  InsuranceBottomSheet({
    super.key,
    required this.controller,
    required this.nameCtrl,
    required this.numberCtrl,
    required this.providerCtrl,
    required this.dateCtrl,
    required this.onUpload,
    required this.onSubmit,
    required this.isEdit,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = controller as dynamic;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w(20),
        vertical: Dimensions.h(20),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: Dimensions.h(10)),

              /// TITLE
              Text(
                AppStrings.insurance.tr,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: Dimensions.h(20)),

              /// INPUT FIELDS
              _buildInput(nameCtrl, AppStrings.insuranceName.tr),
              _buildInput(numberCtrl, AppStrings.insuranceNumber.tr),
              _buildInput(providerCtrl, AppStrings.insuranceProvider.tr),

              DatePickerField(
                controller: dateCtrl,
                hintText: AppStrings.expirationDate.tr,
              ),

              SizedBox(height: Dimensions.h(10)),

              /// UPLOAD BUTTON
              Obx(() {
                return GestureDetector(
                  onTap: onUpload,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file,
                            size: 18, color: AppColors.primaryColor),
                        const SizedBox(width: 10),
                        Text(
                          c.insurancePhoto.value != null
                              ? c.insurancePhoto.value!.path.split('/').last
                              : AppStrings.uploadFiles.tr,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              SizedBox(height: Dimensions.h(20)),

              /// SUBMIT BUTTON
              Obx(() {
                return GestureDetector(
                  onTap: c.isLoading.value
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      onSubmit();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: c.isLoading.value
                          ? const CupertinoActivityIndicator(color: Colors.white)
                          : Text(
                        isEdit
                            ? AppStrings.update.tr
                            : AppStrings.addInsurance.tr,
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: Dimensions.h(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController ctrl, String hint) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(15)),
      child: HVTextField(
        controller: ctrl,
        hint: hint,
        validator: AppValidators.required(),
      ),
    );
  }
}
