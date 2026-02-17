import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/helper/date_time_converter/date_time_converter.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/service/api_url.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../controller/insurance_myself_controller.dart';
import '../widget/insurance_bottomsheet_widget.dart';
import '../widget/insurance_card_widget.dart';

class InsuranceMyselfScreen extends StatefulWidget {
  const InsuranceMyselfScreen({super.key});

  @override
  State<InsuranceMyselfScreen> createState() => _InsuranceMyselfScreenState();
}

class _InsuranceMyselfScreenState extends State<InsuranceMyselfScreen> {

  final InsuranceMyselfController controller =
  Get.put(InsuranceMyselfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppStrings.insurance.tr),
      backgroundColor: AppColors.whiteColor,

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.insuranceSelfList.isEmpty) {
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
            itemCount: controller.insuranceSelfList.length,
            itemBuilder: (context, index) {
              final data = controller.insuranceSelfList[index];

              final imageUrl = ApiUrl.buildImageUrl(data.insurancePhoto.toString());


              return InsuranceCard(
                image: imageUrl,
                insName: data.name ?? "N/A",
                insNumber: data.number ?? "N/A",
                provider: data.insuranceProvider ?? "N/A",
                expDate: DateTimeHelper.dateTime(data.expiryDate ?? "N/A") ,

                /// EDIT
                onEdit: () {
                  controller.name.text = data.name ?? '';
                  controller.number.text = data.number ?? '';
                  controller.provider.text = data.insuranceProvider ?? '';
                  controller.expirationDate.text = data.expiryDate ?? '';
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
                        onUpload: () => controller.pickInsurancePhoto(),
                        onSubmit: () =>
                            controller.updateInsurance(data.sId.toString()),
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

      /// ADD BUTTON
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
                onUpload: () => controller.pickInsurancePhoto(),
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
