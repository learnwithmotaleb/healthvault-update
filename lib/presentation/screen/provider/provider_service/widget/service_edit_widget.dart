import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../widget/hv_button.dart';
import '../../../../widget/hv_text_field.dart';
import '../controller/provider_service_controller.dart';

class EditItemBottomSheet extends StatelessWidget {
  final String serviceId;
  final String title;
  final int price;

  EditItemBottomSheet({
    super.key,
    required this.serviceId,
    required this.title,
    required this.price,

  });

  final ProviderServiceController controller =
  Get.find<ProviderServiceController>();

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: title);
    final priceController = TextEditingController(text: price.toString());

    return Container(
      padding: EdgeInsets.all(Dimensions.w(20)),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
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
              controller: titleController,
              hint: "Enter service title",
            ),

            SizedBox(height: Dimensions.h(16)),

            /// -------- PRICE --------
            Text("Price", style: AppTextStyles.label),
            SizedBox(height: Dimensions.h(10)),
            HVTextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              hint: "Enter price",
            ),

            SizedBox(height: Dimensions.h(16)),


            SizedBox(height: Dimensions.h(30)),

            /// -------- UPDATE BUTTON --------
            HVButton(
              label: "Update Service",
              onPressed: () async {
                final updatedTitle = titleController.text.trim();
                final updatedPrice =
                    int.tryParse(priceController.text.trim()) ?? 0;

                if (updatedTitle.isEmpty || updatedPrice <= 0) {
                  AppSnackBar.fail("Please enter valid data");
                  return;
                }

                await controller.updateService(
                  serviceId: serviceId,
                  title: updatedTitle,
                  price: updatedPrice,
                );


                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
