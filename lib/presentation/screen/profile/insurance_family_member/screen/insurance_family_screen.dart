import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';

import '../../insurance_self_member/widget/insurance_bottomsheet_widget.dart';
import '../../insurance_self_member/widget/insurance_card_widget.dart';
import '../controller/insurance_family_controller.dart';

class InsuranceFamilyScreen extends StatelessWidget {
  InsuranceFamilyScreen({super.key});

  final InsuranceFamilyController controller =
  Get.put(InsuranceFamilyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppStrings.insurance.tr),
      backgroundColor: AppColors.whiteColor,

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.insuranceFamilyList.isEmpty) {
          return const Center(
            child: Text(
              "No insurance found",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshInsurance,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: controller.insuranceFamilyList.length,
            itemBuilder: (context, index) {
              final data = controller.insuranceFamilyList[index];

              return InsuranceCard(
                image: AppImages.motalebImage,
                insName: data.name ?? "N/A",
                insNumber: data.number ?? "N/A",
                provider: data.insuranceProvider ?? "N/A",
                expDate: data.expiryDate ?? "N/A",

                /// EDIT
                onEdit: () {
                  controller.name.text = data.name ?? '';
                  controller.number.text = data.number ?? '';
                  controller.provider.text =
                      data.insuranceProvider ?? '';
                  controller.expirationDate.text =
                      data.expiryDate ?? '';
                  controller.insurancePhoto.value = null;

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) {
                      return InsuranceBottomSheet(
                        controller: controller,
                        nameCtrl: controller.name,
                        numberCtrl: controller.number,
                        providerCtrl: controller.provider,
                        dateCtrl: controller.expirationDate,
                        onUpload: () =>
                            controller.pickInsurancePhoto(),
                        onSubmit: () => controller
                            .updateInsurance(data.sId.toString()),
                        isEdit: true,
                      );
                    },
                  );
                },

                /// DELETE
                onDelete: () {
                  controller.deleteInsurance(data.sId ?? "");
                },
              );
            },
          ),
        );
      }),

      /// ADD NEW INSURANCE
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 20),
        onPressed: () {
          controller.name.clear();
          controller.number.clear();
          controller.provider.clear();
          controller.expirationDate.clear();
          controller.insurancePhoto.value = null;

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return InsuranceBottomSheet(
                controller: controller,
                nameCtrl: controller.name,
                numberCtrl: controller.number,
                providerCtrl: controller.provider,
                dateCtrl: controller.expirationDate,
                onUpload: () =>
                    controller.pickInsurancePhoto(fromCamera: false),
                onSubmit: () => controller.addInsurance(),
                isEdit: false,
              );
            },
          );
        },
      ),
    );
  }
}
