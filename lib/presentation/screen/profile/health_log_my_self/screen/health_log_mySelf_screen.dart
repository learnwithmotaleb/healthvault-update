import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthvault/presentation/screen/profile/health_log_my_self/controller/health_log_mySelf_controller.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../../health_log_profile/widget/health_log_bottomsheet_widget.dart';
import '../../health_log_profile/widget/health_log_card.dart';

class HealthLogMyselfScreen extends StatefulWidget {
  const HealthLogMyselfScreen({super.key});

  @override
  State<HealthLogMyselfScreen> createState() => _HealthLogMyselfScreenState();
}

class _HealthLogMyselfScreenState extends State<HealthLogMyselfScreen> {
  final HealthLogMyselfController controller =
  Get.put(HealthLogMyselfController());

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

          if (controller.healthLogSelfList.isEmpty) {
            return const Center(child: Text("No Health Logs Found"));
          }

          return ListView.builder(
            itemCount: controller.healthLogSelfList.length,
            itemBuilder: (context, index) {
              final item = controller.healthLogSelfList[index];

              return HealthLogCard(

                familyMember: item.familyMemberName ?? "Unknown",
                bloodPressure: item.bloodPressure ?? "-",
                heartRate: item.heartRate ?? "-",
                weight: item.weight.toString() ?? "-",
                bloodSugar: item.bloodSugar ?? "-",

                onEdit: () {
                  /// Prefill fields
                  controller.familyMemberName.text =
                      item.familyMemberName ?? "";
                  controller.bloodPressure.text =
                      item.bloodPressure ?? "";
                  controller.heartRate.text =
                      item.heartRate ?? "";
                  controller.weight.text =
                      item.weight.toString() ?? "";
                  controller.bloodSugar.text =
                      item.bloodSugar ?? "";

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => HealthLogBottomSheet(
                      isEdit: true,
                      isFamily: false,
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

      /// ADD HEALTH LOG
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 20),
        onPressed: () {
          controller.clearForm();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) =>  HealthLogBottomSheet(
              isFamily: false,
            ),
          );
        },
      ),
    );
  }
}
