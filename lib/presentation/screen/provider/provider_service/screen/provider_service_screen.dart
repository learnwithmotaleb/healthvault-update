import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/helper/date_time_converter/date_time_converter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/provider_service_controller.dart';
import '../widget/service_add__widget.dart';
import '../widget/service_edit_widget.dart';
import '../widget/services_card.dart';

class ProviderServiceScreen extends StatefulWidget {
  const ProviderServiceScreen({super.key});

  @override
  State<ProviderServiceScreen> createState() => _ProviderServiceScreenState();
}

class _ProviderServiceScreenState extends State<ProviderServiceScreen> {
  final ProviderServiceController controller = Get.put(ProviderServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.service.tr),

      body: Obx(() {
        // ✅ Show shimmer while loading
        if (controller.isLoading.value) {
          return _buildShimmerList();
        }

        if (controller.services.isEmpty) {
          return const Center(child: Text("No services found"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshServices(),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.services.length,
            itemBuilder: (context, index) {
              final service = controller.services[index];

              return ServiceCardWidget(
                title: service.title ?? "",
                subtitle: "Price: \$${service.price ?? 0}",
                address: "Provider Type: ${service.providerType ?? ""}",
                description: "Date: ${DateTimeHelper.dateTime(service.createdAt.toString())}",
                onEdit: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => EditItemBottomSheet(
                      title: service.title ?? "",
                      serviceId: service.sId.toString(),
                      price: service.price!.toInt(),
                    ),
                  );
                },
                onDelete: () async {
                  final confirm = await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text("Are you sure you want to delete this service?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    controller.deleteService(service.sId!);
                  }
                },
              );
            },
          ),
        );
      }),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (controller.providerType.value.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Provider type not loaded yet. Please wait.")),
            );
            return;
          }

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => AddItemBottomSheet(
              providerType: controller.providerType.value,
            ),
          );
        },
      ),
    );
  }

  // ✅ Shimmer placeholder list — matches ServiceCardWidget shape
  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6, // number of skeleton cards
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 110,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Text placeholder lines
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Title
                      Container(height: 14, width: 160, color: Colors.white),
                      // Subtitle
                      Container(height: 12, width: 100, color: Colors.white),
                      // Address
                      Container(height: 12, width: 130, color: Colors.white),
                      // Description
                      Container(height: 12, width: 180, color: Colors.white),
                    ],
                  ),
                ),
                // ✅ Edit/Delete icon placeholders
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 20, width: 20, color: Colors.white),
                    const SizedBox(height: 10),
                    Container(height: 20, width: 20, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}