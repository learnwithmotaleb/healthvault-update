import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/provider_edit_schedule_controller.dart';
import '../widget/edit_schedule_widget.dart';
import '../widget/schedule_card_widget.dart';

class ProviderEditScheduleScreen extends StatefulWidget {
  const ProviderEditScheduleScreen({super.key});

  @override
  State<ProviderEditScheduleScreen> createState() =>
      _ProviderEditScheduleScreenState();
}

class _ProviderEditScheduleScreenState
    extends State<ProviderEditScheduleScreen> {

  final controller = Get.put(ProviderEditScheduleController());

  @override
  void initState() {
    super.initState();
    // 🔑 Replace with actual profileId
    controller.getProviderAvailability("YOUR_PROFILE_ID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.editSchedule.tr),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.availabilityList.isEmpty) {
          return const Center(child: Text("No schedule found"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double totalWidth = constraints.maxWidth;
              double spacing = 8;
              int itemsPerRow = 2;

              double itemWidth =
                  (totalWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: controller.availabilityList.map((dayData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ---------------- Day Title ----------------
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          dayData.dayOfWeek ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      /// ---------------- Slots ----------------
                      Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: dayData.availabilitySlots!
                            .map((slot) => SizedBox(
                          width: itemWidth,
                          height: Dimensions.h(90),
                          child: ScheduleCard(
                            day: dayData.dayOfWeek ?? "",
                            fromTime: slot.startTime ?? "",
                            toTime: slot.endTime ?? "",
                            onEdit: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (_) => EditScheduleBottomSheet(),
                              );
                            },
                            onDelete: () async {
                              // Optional: show a confirmation dialog before deleting
                              bool confirm = await showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Confirm Delete"),
                                  content: const Text(
                                      "Are you sure you want to delete this slot?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(ctx, false),
                                        child: const Text("Cancel")),
                                    TextButton(
                                        onPressed: () => Navigator.pop(ctx, true),
                                        child: const Text("Delete")),
                                  ],
                                ),
                              );

                              if (confirm) {
                                controller.deleteAvailabilitySlot(
                                  availabilityDayId: slot.availabilityDayId.toString(),
                                  availabilitySlotId: slot.sId!,
                                );
                              }
                            },
                          ),
                        ))
                            .toList(),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

          onPressed: (){

        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (_) => EditScheduleBottomSheet(),
        );

      }),
    );
  }
}
