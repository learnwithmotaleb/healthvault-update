import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/hv_button.dart';
import '../../../../widget/hv_text_field.dart';
import '../controller/provider_service_controller.dart';

class AddItemBottomSheet extends StatelessWidget {
  final String providerType;

  const AddItemBottomSheet({  // ✅ added const
    super.key,
    required this.providerType,
  });

  // ✅ Use Get.find() instead of Get.put() to reuse existing controller
  ProviderServiceController get controller =>
      Get.find<ProviderServiceController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.w(20)),
          topRight: Radius.circular(Dimensions.w(20)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -------- TITLE --------
            Text("Title", style: AppTextStyles.label),
            SizedBox(height: Dimensions.h(10)),
            HVTextField(
              controller: controller.title,
              hint: "Enter your title..",
            ),

            SizedBox(height: Dimensions.h(16)),

            /// -------- PRICE --------
            Text("Price", style: AppTextStyles.label),
            SizedBox(height: Dimensions.h(10)),
            HVTextField(
              controller: controller.price,
              hint: "Enter price..",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: Dimensions.h(24)),

            HVButton(
              label: AppStrings.add.tr,
              onPressed: () async {
                final title = controller.title.text.trim();
                final price = int.tryParse(controller.price.text.trim()) ?? 0;

                if (title.isEmpty || price <= 0) {
                  AppSnackBar.fail("Please fill all fields correctly!");
                  return;
                }

                await controller.createService(
                  title: title,
                  price: price,
                  providerType: providerType,
                );


                // ✅ Clear first, then close
                controller.title.clear();
                controller.price.clear();

                // ✅ Use Navigator instead of Get.back() for bottom sheets
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
            SizedBox(height: Dimensions.h(24)),
          ],
        ),
      ),
    );
  }
}