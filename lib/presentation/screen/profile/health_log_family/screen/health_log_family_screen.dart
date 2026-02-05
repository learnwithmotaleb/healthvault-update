import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../health_log_profile/widget/health_log_card.dart';
import '../../health_log_profile/widget/health_log_bottomsheet_widget.dart';
import '../controller/health_log_family_controller.dart';

class HealthLogFamilyScreen extends StatefulWidget {
  const HealthLogFamilyScreen({super.key});

  @override
  State<HealthLogFamilyScreen> createState() =>
      _HealthLogFamilyScreenState();
}

class _HealthLogFamilyScreenState extends State<HealthLogFamilyScreen> {

  final HealthLogFamilyController controller =
  Get.put(HealthLogFamilyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppStrings.healthLogs.tr),
      backgroundColor: AppColors.whiteColor,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.healthLogFamilyList.isEmpty) {
            return const Center(
              child: Text("No Health Logs Found"),
            );
          }

          return ListView.builder(
            itemCount: controller.healthLogFamilyList.length,
            itemBuilder: (context, index) {
              final item = controller.healthLogFamilyList[index];

              return HealthLogCard(
                familyMember: item.familyMemberName ?? "Unknown",
                bloodPressure: item.bloodPressure ?? "-",
                heartRate: item.heartRate ?? "-",
                weight: item.weight.toString() ?? "-",
                bloodSugar: item.bloodSugar ?? "-",

                onEdit: () {
                  // Prefill fields
                  controller.familyMemberName.text =
                      item.familyMemberName ?? "";
                  controller.bloodPressure.text =
                      item.bloodPressure ?? "";
                  controller.heartRate.text =
                      item.heartRate ?? "";
                  controller.bloodSugar.text =
                      item.bloodSugar ?? "";
                  controller.weight.text =
                      item.weight?.toString() ?? "";

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => HealthLogBottomSheet(
                      isEdit: true,
                      healthLogId: item.sId,
                    ),
                  );
                },

                onDelete: () {
                  controller.deleteHealthLog(item.sId!);
                },
              );
            },
          );
        }),
      ),

      /// ADD NEW HEALTH LOG
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 20),
        onPressed: () {
          controller.familyMemberName.clear();
          controller.bloodPressure.clear();
          controller.heartRate.clear();
          controller.weight.clear();
          controller.bloodSugar.clear();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) =>  HealthLogBottomSheet(),
          );
        },
      ),
    );
  }
}
