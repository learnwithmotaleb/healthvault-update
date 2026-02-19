import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/helper/date_time_converter/date_time_converter.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/details_controller.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailsController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Appointment Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ── Provider ──
            _SectionCard(
              title: "Provider",
              children: [
                _InfoRow(label: "Name", value: controller.provider["fullName"]),
                _InfoRow(label: "Address", value: controller.provider["address"]),
                _InfoRow(label: "Specialization", value: controller.provider["specialization"]),
                _InfoRow(label: "Experience", value: controller.provider["yearsOfExperience"] != null
                    ? "${controller.provider["yearsOfExperience"]} years"
                    : null),
                _InfoRow(label: "License No.", value: controller.provider["medicalLicenseNumber"]),
                _InfoRow(label: "Type", value: (controller.provider["providerType"] as Map<String, dynamic>?)?["label"]),
              ],
            ),

            const SizedBox(height: 12),

            /// ── Service ──
            _SectionCard(
              title: "Service",
              children: [
                _InfoRow(label: "Title", value: controller.service["title"]),
                _InfoRow(label: "Price", value: controller.service["price"] != null
                    ? "\$${controller.service["price"]}"
                    : null),
                _InfoRow(label: "Provider Type", value: controller.service["providerType"]),
              ],
            ),

            const SizedBox(height: 12),

            /// ── Appointment ──
            _SectionCard(
              title: "Appointment",
              children: [
                _InfoRow(label: "Date & Time", value:DateTimeHelper.dateTime(controller.appointment["appointmentDateTime"])) ,
                _InfoRow(label: "Status", value: controller.appointment["status"]),
                _InfoRow(label: "Reason", value: controller.appointment["reason"]),
              ],
            ),

            const SizedBox(height: 12),

            /// ── Patient ──
            _SectionCard(
              title: "Patient",
              children: [
                _InfoRow(label: "Name", value: controller.normalUser["fullName"]),
                _InfoRow(label: "Email", value: controller.normalUser["email"]),
                _InfoRow(label: "Phone", value: controller.normalUser["phone"]),
              ],
            ),

            const SizedBox(height: 12),

            /// ── Availability ──
            if ((controller.provider["availabilityDays"] as List<dynamic>? ?? []).isNotEmpty) ...[
              _SectionCard(
                title: "Availability",
                children: [
                  ...(controller.provider["availabilityDays"] as List<dynamic>).map((day) {
                    final dayMap = day as Map<String, dynamic>;
                    final slots = (dayMap["availabilitySlots"] as List<dynamic>? ?? [])
                        .map((s) {
                      final slot = s as Map<String, dynamic>;
                      return "From: ${slot["startTime"]} - To: ${slot["endTime"]}";
                    })
                        .join("\n");
                    return _InfoRow(
                      label: dayMap["dayOfWeek"]?.toString() ?? "",
                      value: slots.isNotEmpty ? slots : "No slots",
                    );
                  }),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Reusable Section Card
// ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              title,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children
                  .where((w) => w is _InfoRow ? (w as _InfoRow).value != null : true)
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Reusable Info Row
// ─────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),
          const Text(":  ", style: TextStyle(color: Colors.grey)),
          Expanded(
            child: Text(
              value!,
              style: AppTextStyles.body.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}