import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../controller/provider_selection_controller.dart';
import '../widget/selectable_card_widget.dart';

class ProviderSelectionScreen extends StatelessWidget {
  ProviderSelectionScreen({super.key});

  // Initialize controller
  final ProviderSelectionController controller = Get.put(ProviderSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Select Provider Type".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0.5,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.providerTypes.isEmpty) {
          return Center(child: Text("No provider types available".tr));
        }

        return ListView(
          padding: const EdgeInsets.all(14),
          children: [
            ...List.generate(controller.providerTypes.length, (index) {
              final item = controller.providerTypes[index];
              return Column(
                children: [
                  SelectableCard(
                    title: item.label ?? item.key ?? "Unknown",
                    primaryColor: AppColors.providerSelectionColor,
                    isSelected: controller.selectedIndex.value == index,
                    onTap: () => controller.selectProvider(index),
                  ),
                  SizedBox(height: Dimensions.h(8)),
                ],
              );
            }),
            SizedBox(height: Dimensions.h(40)),

            // Bottom logo
            Center(
              child: Column(
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    height: Dimensions.h(60),
                  ),
                  SizedBox(height: Dimensions.h(10)),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
