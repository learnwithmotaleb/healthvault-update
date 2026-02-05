import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
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
  final ProviderServiceController controller =
  Get.put(ProviderServiceController());




  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.service.tr),



      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.services.isEmpty) {
          return const Center(child: Text("No services found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.services.length,
          itemBuilder: (context, index) {
            final service = controller.services[index];

            return ServiceCardWidget(
              data: {
                "image": AppImages.motalebImage,
                "title": service.title ?? "",
                "subtitle": "Price: €${service.price ?? 0}",
                "address": "Provider ID: ${service.providerId ?? ""}",
                "description": "Created At: ${service.createdAt ?? ""}",
              },
              onEdit: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => EditItemBottomSheet(
                    title: service.title ??"",
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
                    content: const Text(
                        "Are you sure you want to delete this service?"),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context, true),
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
        );
      }),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => AddItemBottomSheet(


              providerType: controller.services[0].providerType.toString(), //

              // ✅ FIX
            ),
          );
        },
      ),
    );
  }
}
