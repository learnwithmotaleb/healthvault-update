import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../controller/select_reminder_controller.dart';
import '../widget/select_reminder_card.dart';

class SelectReminderScreen extends StatefulWidget {
  const SelectReminderScreen({super.key});

  @override
  State<SelectReminderScreen> createState() => _SelectReminderScreenState();
}

class _SelectReminderScreenState extends State<SelectReminderScreen> {
  final controller = Get.put(SelectReminderController());

  @override
  void initState() {
    super.initState();
    controller.getAllReminders();
  }

  Future<void> _refreshReminders() async {
    await controller.refreshReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.reminder.tr,
        showBack: false,
      ),
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Empty state
        if (controller.reminders.isEmpty) {
          return RefreshIndicator(
            onRefresh: _refreshReminders,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 100),
                Icon(
                  Icons.notifications_off,
                  size: 80,
                  color: AppColors.greyColor,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "No reminders found",
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // List of reminders
        return RefreshIndicator(
          onRefresh: _refreshReminders,
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: controller.reminders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = controller.reminders[index];

              return ReminderCard(
                pillName: item.pillName ?? "--",
                dosage: "${item.dosage ?? ''} Tablet",
                timesPerDay: item.timesPerDay ?? 0,
                schedule: item.schedule ?? "--",
                times: item.times ?? [],
                startDate: item.startDate ?? "--",
                endDate: item.endDate ?? "--",
                instructions: item.instructions ?? "--",
                assignedTo: item.assignedTo ?? "--",
                  onDelete: () {
                    // Show confirmation dialog
                    Get.defaultDialog(
                      title: "Delete Reminder",
                      middleText: "Are you sure you want to delete this reminder?",
                      textCancel: "Cancel",
                      textConfirm: "Delete",
                      confirmTextColor: AppColors.whiteColor,
                      onConfirm: () {
                        Get.back(); // Close dialog
                        controller.deleteReminder(item.sId.toString());
                      },
                    );
                  },

                onEdit: () {
                  Get.toNamed(
                    RoutePath.editReminder,
                    arguments: {'id': item.sId.toString()},
                  )?.then((value) => _refreshReminders());
                },
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RoutePath.addReminder)?.then((value) {
            _refreshReminders(); // Refresh after adding
          });
        },

        child: Icon(Icons.add,size: 30,),


      ),
    );
  }
}
